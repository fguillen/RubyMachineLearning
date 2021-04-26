require "csv"
require "classifier-reborn"

class BankExpenseClassifier
  def train
    @data = BankExpenseClassifier.load_csv_in_json("#{__dir__}/data/bank_expenses.csv")
    categories = BankExpenseClassifier.load_categories(@data)
    @samples = BankExpenseClassifier.extract_samples(@data)


    @classifier = ClassifierReborn::Bayes.new(categories, stopwords: [])

    BankExpenseClassifier.train(@classifier, @samples)
  end

  def generate_result
    output_string =
      CSV.generate do |csv|
        headers = @data[0].keys
        headers << "Guessed"
        headers << "Same"
        headers << "Score"
        headers << "Classifications"

        @data.each do |element|
          category_guessed = classify(element)
          score = classify_with_score(element)[1]
          classifications = classifications(element)

          csv << [
            element["PostingText"],
            element["Purpose"],
            element["Other"],
            element["Account"],
            element["BankCode"],
            element["Category"],
            category_guessed,
            category_guessed == ClassifierReborn::CategoryNamer.prepare_name(element["Category"]).to_s,
            score,
            classifications.map { |e| "#{e[0]}:#{e[1]}" }.join(" ")
          ]
        end
      end

    File.write("#{__dir__}/data/#{Time.now}-bank_expenses_result.csv", output_string)
  end

  def validator
    samples = BankExpenseClassifier.sample_data_in_array_of_arrays(@samples)
    ClassifierReborn::ClassifierValidator.cross_validate(@classifier, samples, 5)
  end

  def self.sample_data_in_array_of_arrays(samples)
    result = []

    samples.each do |sample|
      result << [sample["category"], sample["text"]]
    end

    result
  end

  def classify_uncategorized
    @data.each do |element|
      if element["Category"].nil?
        text = BankExpenseClassifier.concatenate_text(element)
        category = classify(element)

        puts "#{text} -> #{category}"
      end
    end
  end

  def classify(element)
    text = BankExpenseClassifier.concatenate_text(element)
    @classifier.classify(text)
  end

  def classify_with_score(element)
    text = BankExpenseClassifier.concatenate_text(element)
    @classifier.classify_with_score(text)
  end

  def classifications(element)
    text = BankExpenseClassifier.concatenate_text(element)
    classifications = @classifier.classifications(text)
    classifications.sort_by { |_k, v| v }.reverse
  end

  def self.train(classifier, samples)
    samples.each do |sample|
      classifier.train(sample["category"], sample["text"])
    end
  end

  def self.extract_samples(data)
    results = []

    data.each do |element|
      unless element["Category"].nil?
        results << {
          "text" => concatenate_text(element),
          "category" => element["Category"]
        }
      end
    end

    results
  end

  def self.concatenate_text(data_element)
    "#{data_element["PostingText"]} #{data_element["Other"]} #{data_element["Account"]} #{data_element["BankCode"]}"
  end

  def self.load_categories(data)
    result = []

    data.each do |element|
      if !element["Category"].nil? && !result.include?(element["Category"])
        result << element["Category"]
      end
    end

    result
  end

  def self.load_csv_in_json(file_path)
    csv = CSV.open(file_path, headers: true, converters: :all)
    csv.to_a.map(&:to_hash)
  end
end
