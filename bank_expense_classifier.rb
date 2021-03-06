require "csv"
require "classifier-reborn"

require_relative "utils"

class BankExpenseClassifier
  def train
    @data = Utils.load_csv_in_json("#{__dir__}/data/expenses.csv")
    @samples = BankExpenseClassifier.extract_samples(@data)


    @classifier = ClassifierReborn::Bayes.new(enable_stemmer: false, stopwords: [], enable_threshold: true, threshold: -30.0)

    Utils.train(@classifier, @samples)
  end

  def generate_result
    output_string =
      CSV.generate do |csv|
        # headers
        csv << [
          "Posting text",
          "Purpose",
          "Beneficiary/payer",
          "Account number",
          "BankCode",
          "Category",
          "Guessed",
          "Same",
          "Score",
          "Classifications"
        ]

        @data.each do |element|
          category_guessed = classify(element)
          score = classify_with_score(element)[1]
          classifications = classifications(element)

          csv << [
            element["Posting text"],
            element["Purpose"],
            element["Beneficiary/payer"],
            element["Account number"],
            element["BankCode"],
            element["Category"],
            category_guessed,
            category_guessed == ClassifierReborn::CategoryNamer.prepare_name(element["Category"]).to_s,
            score,
            classifications.map { |e| "#{e[0]}:#{e[1]}" }.join(" ")
          ]
        end
      end

    File.write("#{__dir__}/data/#{Time.now}_expenses_result.csv", output_string)
  end

  def validator
    samples = BankExpenseClassifier.sample_data_in_array_of_arrays(@samples)
    ClassifierReborn::ClassifierValidator.cross_validate(@classifier, samples, 5)
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
    [
      Utils.remove_numbers(data_element["Purpose"]),
      data_element["Posting text"],
      data_element["Beneficiary/payer"],
      data_element["Account number"]
    ].map { |e| Utils.slug(e.to_s) }.join(" ").strip
  end
end
