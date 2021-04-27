require "minitest/autorun"

require_relative "../bank_expense_classifier"

class BankExpenseClassifierTest < Minitest::Test
  def test_generate_result
    classifier = BankExpenseClassifier.new
    classifier.train
    classifier.generate_result
  end
end
