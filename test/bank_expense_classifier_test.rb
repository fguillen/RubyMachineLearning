require "minitest/autorun"

require_relative "../visa_expense_classifier"

class VisaExpenseClassifierTest < Minitest::Test
  def test_concatenate_text
    data_element = {
      "original currency" => "USD",
      "description of transaction" => "PAYPAL",
      "Category" => "CATEGORY"
    }

    result = VisaExpenseClassifier.concatenate_text(data_element)
    assert_equal("USD PAYPAL", result)
  end
end
