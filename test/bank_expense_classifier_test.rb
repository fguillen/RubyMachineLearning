require "minitest/autorun"

require_relative "../bank_expense_classifier"

class BankExpenseClassifierTest < Minitest::Test
  # def test_load_csv_in_json
  #   result = BankExpenseClassifier.load_csv_in_json("#{__dir__}/../data/bank_expenses.csv")
  #   assert_equal("EIGENE KREDITKARTENABRECHN.", result[0]["PostingText"])
  # end

  # def test_load_categories
  #   data = [
  #     { "Category" => "CATEGORY_1" },
  #     { "Category" => "CATEGORY_2" },
  #     { "Category" => "CATEGORY_3" },
  #     { "Category" => "CATEGORY_1" }
  #   ]

  #   result = BankExpenseClassifier.load_categories(data)
  #   assert_equal(["CATEGORY_1", "CATEGORY_2", "CATEGORY_3"], result)
  # end

  # def test_concatenate_text
  #   data_element = {
  #     "PostingText" => "POSTING_TEXT",
  #     "Purpose" => "PURPOSE",
  #     "Other" => "OTHER",
  #     "Account" => "ACCOUNT",
  #     "BankCode" => "BANK_CODE",
  #     "Category" => "CATEGORY"
  #   }

  #   result = BankExpenseClassifier.concatenate_text(data_element)
  #   assert_equal("POSTING_TEXT PURPOSE OTHER ACCOUNT BANK_CODE", result)
  # end

  # def test_extract_samples
  #   data = [
  #     {
  #       "PostingText" => "A1",
  #       "Purpose" => "B1",
  #       "Other" => "C1",
  #       "Account" => "D1",
  #       "BankCode" => "E1",
  #       "Category" => "CATEGORY_1"
  #     },
  #     {
  #       "PostingText" => "A2",
  #       "Purpose" => "B2",
  #       "Other" => "C2",
  #       "Account" => "D2",
  #       "BankCode" => "E2",
  #       "Category" => "CATEGORY_2"
  #     },
  #     {
  #       "PostingText" => "A3",
  #       "Purpose" => "B3",
  #       "Other" => "C3",
  #       "Account" => "D3",
  #       "BankCode" => "E3",
  #       "Category" => "CATEGORY_3"
  #     },
  #     {
  #       "PostingText" => "A4",
  #       "Purpose" => "B4",
  #       "Other" => "C4",
  #       "Account" => "D4",
  #       "BankCode" => "E4",
  #       "Category" => nil
  #     }
  #   ]

  #   result = BankExpenseClassifier.extract_samples(data)

  #   assert_equal(3, result.length)
  #   assert_equal("CATEGORY_1", result[0]["category"])
  #   assert_equal("A1 B1 C1 D1 E1", result[0]["text"])
  # end

  # def test_classify_uncategorized
  #   bank_expense_classifier = BankExpenseClassifier.new
  #   bank_expense_classifier.train
  #   bank_expense_classifier.classify_uncategorized
  # end

  # def test_validator
  #   bank_expense_classifier = BankExpenseClassifier.new
  #   bank_expense_classifier.train
  #   bank_expense_classifier.validator
  # end

  def test_generate_result
    bank_expense_classifier = BankExpenseClassifier.new
    bank_expense_classifier.train
    bank_expense_classifier.generate_result
  end

  # def test_classifications
  #   element = {
  #     "PostingText" => "GELDAUTOMAT",
  #     "Purpose" => "GBP      40,00KURS0,7020990KURS VOM 17.11.15     VPFDLBG        AM14.11.15LBG  - BANK CASHPOINT   GB",
  #     "Other" => "EC-GA EMV   0   GEB.EU 7,50",
  #     "Account" => "959567017",
  #     "BankCode" => "50050000",
  #     "Category" => "holidays"
  #   }

  #   bank_expense_classifier = BankExpenseClassifier.new
  #   bank_expense_classifier.train

  #   result = bank_expense_classifier.classifications(element)

  #   assert_equal("Servers", result[0][0])
  #   assert_equal(-43.806058143287004, result[0][1])
  # end

  # def test_prepare_name
  #   result = ClassifierReborn::CategoryNamer.prepare_name("tarjeta")
  #   puts result.to_s
  #   puts result.to_s == "Tarjeta"
  # end
end
