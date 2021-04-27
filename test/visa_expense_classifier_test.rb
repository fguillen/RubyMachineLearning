require "minitest/autorun"

require_relative "../bank_expense_classifier"

class BankExpenseClassifierTest < Minitest::Test
  def test_concatenate_text
    data_element = {
      "Posting text" => "POSTING_TEXT",
      "Purpose" => "PURPOSE 44+44/2",
      "Beneficiary/payer" => "OTHER",
      "Account number" => "ACCOUNT",
      "BankCode" => "BANK_CODE",
      "Category" => "CATEGORY"
    }

    result = BankExpenseClassifier.concatenate_text(data_element)
    assert_equal("PURPOSE POSTING_TEXT OTHER ACCOUNT", result)
  end

  def test_concatenate_text_2
    data_element = {
      "Posting text" => "SONSTIGER EINZUG",
      "Purpose" => "PURPOSE",
      "Beneficiary/payer" => "OTHER ACCOUNT",
      "Account number" => "1176510",
      "BankCode" => "BANK_CODE",
      "Category" => "CATEGORY"
    }

    result = BankExpenseClassifier.concatenate_text(data_element)
    assert_equal("PURPOSE SONSTIGEREINZUG OTHERACCOUNT 1176510", result)
  end

  def test_extract_samples
    data = [
      {
        "Posting text" => "A1",
        "Purpose" => "B1",
        "Beneficiary/payer" => "C1",
        "Account number" => "D1",
        "BankCode" => "E1",
        "Category" => "CATEGORY_1"
      },
      {
        "Posting text" => "A2",
        "Purpose" => "B2",
        "Beneficiary/payer" => "C2",
        "Account number" => "D2",
        "BankCode" => "E2",
        "Category" => "CATEGORY_2"
      },
      {
        "Posting text" => "A3",
        "Purpose" => "B3",
        "Beneficiary/payer" => "C3",
        "Account number" => "D3",
        "BankCode" => "E3",
        "Category" => "CATEGORY_3"
      },
      {
        "Posting text" => "A4",
        "Purpose" => "B4",
        "Beneficiary/payer" => "C4",
        "Account number" => "D4",
        "BankCode" => "E4",
        "Category" => nil
      }
    ]

    result = BankExpenseClassifier.extract_samples(data)

    assert_equal(3, result.length)
    assert_equal("CATEGORY_1", result[0]["category"])
    assert_equal("B A1 C1 D1", result[0]["text"])
  end

end
