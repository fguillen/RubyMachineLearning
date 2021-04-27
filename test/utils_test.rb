require "minitest/autorun"

require_relative "../bank_expense_classifier"
require_relative "../visa_expense_classifier"

class UtilsTest < Minitest::Test
  # def test_load_csv_in_json
  #   result = Utils.load_csv_in_json("#{__dir__}/../data/expenses.csv")
  #   assert_equal("EIGENE KREDITKARTENABRECHN.", result[0]["Posting text"])
  # end

  # def test_load_categories
  #   data = [
  #     { "Category" => "CATEGORY_1" },
  #     { "Category" => "CATEGORY_2" },
  #     { "Category" => "CATEGORY_3" },
  #     { "Category" => "CATEGORY_1" }
  #   ]

  #   result = Utils.load_categories(data)
  #   assert_equal(["CATEGORY_1", "CATEGORY_2", "CATEGORY_3"], result)
  # end

  # def test_slug
  #   assert_equal("Wadus_", Utils.slug("--Wadu-s*,._"))
  # end

  # def test_prepare_name
  #   result = ClassifierReborn::CategoryNamer.prepare_name("tarjeta")
  #   puts result.to_s
  #   puts result.to_s == "Tarjeta"
  # end

  def test_train
    classifier = ClassifierReborn::Bayes.new(enable_stemmer: false, stopwords: [], enable_threshold: true, threshold: -30.0)
    sample = { "text" => "USD PAYPAL", "category" => "Servers" }
    Utils.train(classifier, [sample])
  end
end
