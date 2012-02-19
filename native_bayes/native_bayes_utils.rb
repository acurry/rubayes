require "#{Dir.pwd}/native_bayes/common_words.rb"
require "stemmer"

module NativeBayesUtils
  def word_count(document)
    words = document.gsub(/[^\w\s]/,"").split
    d = Hash.new
    words.each do |word|
      word.downcase!
      key = word.stem
      unless COMMON_WORDS.include?(word)
        d[key] ||= 0
        d[key] += 1
      end
    end
    d
  end
end