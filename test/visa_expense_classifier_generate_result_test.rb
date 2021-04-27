require "minitest/autorun"

require_relative "../visa_expense_classifier"

class VisaExpenseClassifierTest < Minitest::Test
  def test_generate_result
    classifier = VisaExpenseClassifier.new
    classifier.train
    classifier.generate_result
  end
end
