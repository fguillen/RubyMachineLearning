# RubyMachineLearning
Basic (WIP) exercise to test Machine Learning libraries in Ruby

## Run

### Bank

Download the BankExpenses spreadsheet in csv format and store it in:

```
/data/expenses.csv
```

Run

```
ruby -Itest test/bank_expense_classifier_generate_result_test.rb
```

The results should be in:

```
/data/[Date]_expenses_result.csv
```

### Visa

Download the VisaExpenses spreadsheet in csv format and store it in:

```
/data/visa_expenses.csv
```

Run

```
ruby -Itest test/visa_expense_classifier_generate_result_test.rb
```

The results should be in:

```
/data/[Date]_visa_expenses_result.csv
```
