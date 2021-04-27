require "csv"
require "classifier-reborn"

require_relative "utils"

class VisaExpenseClassifier
  def train
    @data = Utils.load_csv_in_json("#{__dir__}/data/visa_expenses.csv")
    @samples = VisaExpenseClassifier.extract_samples(@data)


    @classifier = ClassifierReborn::Bayes.new(enable_stemmer: false, stopwords: [], enable_threshold: true, threshold: -30.0)

    Utils.train(@classifier, @samples)
  end

  def generate_result
    output_string =
      CSV.generate do |csv|
        # headers
        csv << [
          "original currency",
          "description of transaction",
          "Category",
          "Guessed",
          "Same?",
          "Score",
          "Classifications"
        ]

        @data.each do |element|
          category_guessed = classify(element)
          score = classify_with_score(element)[1]
          classifications = classifications(element)

          csv << [
            element["original currency"],
            element["description of transaction"],
            element["Category"],
            category_guessed,
            category_guessed == ClassifierReborn::CategoryNamer.prepare_name(element["Category"]).to_s,
            score,
            classifications.map { |e| "#{e[0]}:#{e[1]}" }.join(" ")
          ]
        end
      end

    File.write("#{__dir__}/data/#{Time.now}_visa_expenses_result.csv", output_string)
  end

  def validator
    samples = VisaExpenseClassifier.sample_data_in_array_of_arrays(@samples)
    ClassifierReborn::ClassifierValidator.cross_validate(@classifier, samples, 5)
  end

  def classify(element)
    text = VisaExpenseClassifier.concatenate_text(element)
    puts "XXX: text: #{text}"
    @classifier.classify(text)
  end

  def classify_with_score(element)
    text = VisaExpenseClassifier.concatenate_text(element)
    @classifier.classify_with_score(text)
  end

  def classifications(element)
    text = VisaExpenseClassifier.concatenate_text(element)
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
      data_element["original currency"],
      Utils.remove_numbers(data_element["description of transaction"])
    ].map { |e| Utils.slug(e.to_s) }.join(" ").strip
  end
end
