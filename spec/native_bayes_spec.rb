require "#{Dir.pwd}/native_bayes/native_bayes.rb"

describe NativeBayes do
  context "when constructed should have" do
    it "@words, a hash"
    it "@total_words, an integer"
    it "@categories_document, a hash"
    it "@total_documents, an integer"
    it "@categories_words, a hash"
    it "@threshold, a float"
  end
end