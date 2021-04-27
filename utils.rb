require "csv"
require "classifier-reborn"

class Utils
  def self.validator(classifier, samples)
    samples_formatted = BankExpenseClassifier.sample_data_in_array_of_arrays(samples)
    ClassifierReborn::ClassifierValidator.cross_validate(classifier, samples_formatted, 5)
  end

  def self.sample_data_in_array_of_arrays(samples)
    result = []

    samples.each do |sample|
      result << [sample["category"], sample["text"]]
    end

    result
  end

  def self.train(classifier, samples)
    samples.each do |sample|
      classifier.train(sample["category"], sample["text"])
    end
  end

  def self.remove_numbers(string)
    return "" if string.nil?

    string.gsub(/\d/, "").strip
  end

  def self.slug(string)
    string.strip.gsub(/[-.+\/*,]/, "").strip
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
