require "minitest/autorun"
require "classifier-reborn"

class LibraryTest < Minitest::Test
  # def test_classify
  #   classifier = ClassifierReborn::Bayes.new(enable_stemmer: false, auto_categorize: true, stopwords: [], token_filters: [])
  #   classifier.train("One", "This is 1")
  #   classifier.train("Two", "This is 2")
  #   classifier.train("Three", "This is 3")

  #   puts classifier.classifications("This is also 1")
  #   puts classifier.classifications("This is also 2")
  #   puts classifier.classifications("Almost 3")
  #   puts classifier.classifications("Completely 4")
  # end

  # def test_classify_2
  #   classifier = ClassifierReborn::Bayes.new(["red", "blue"], enable_stemmer: false, auto_categorize: true, stopwords: [], token_filters: [])
  #   classifier.train("red", "This is red")
  #   classifier.train("red", "This is also red")
  #   classifier.train("blue", "This is blu")

  #   puts classifier.classifications("This is kid of red")
  #   puts classifier.classifications("This is kid of blue")
  #   puts classifier.classifications("This was red")
  #   puts classifier.classifications("This is kid of red")
  # end

  def test_classify_3
    # classifier = ClassifierReborn::Bayes.new(enable_stemmer: false, auto_categorize: true, stopwords: [], token_filters: [])
    classifier = ClassifierReborn::Bayes.new(enable_stemmer: false, stopwords: [], enable_threshold: true, threshold: -10.0)
    puts "XXX"
    puts classifier.train("One", "9070226003")
    # classifier.train("Two", "This is 1002")
    # classifier.train("Three", "This is 1003")

    # puts classifier.classifications("This is also 1001")
    # puts classifier.classifications("This is also 1002")
    # puts classifier.classifications("Almost 1003")
    # puts classifier.classifications("Completely 1004")
  end
end
