require "classifier-reborn"

classifier = ClassifierReborn::Bayes.new "Interesting", "Uninteresting", "Not clear"
classifier.train "Interesting", "Here are some good words. I hope you love them."
classifier.train "Uninteresting", "Here are some bad words, I hate you."
puts classifier.classify "I hate bad words and you." #=> "Uninteresting"

classifier_snapshot = Marshal.dump classifier
# This is a string of bytes, you can persist it anywhere you like

File.open("classifier.dat", "w") {|f| f.write(classifier_snapshot) }

# This is now saved to a file, and you can safely restart the application
data = File.read("classifier.dat")
trained_classifier = Marshal.load data
trained_classifier.classify "I love" #=> "Interesting"
