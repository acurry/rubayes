# require "#{Dir.pwd}/native_bayes/native_bayes_utils.rb"
require_relative "native_bayes_utils"
require 'set'

class NativeBayes
  include NativeBayesUtils
  
  def initialize
    @words = Hash.new
    @total_words = 0
    @categories_documents = Hash.new
    @total_documents = 0
    @categories_words = Hash.new
    @threshold = 1.5 
    @set_of_categories = Set.new
  end
  
  def add_category(category)
    @set_of_categories << category
    @words[category] = Hash.new
    @categories_documents[category] = 0
    @categories_words[category] = 0
  end
  
  def train(category, document)
    add_category(category) unless @set_of_categories.include? category
    
    word_count(document).each do |word, count|
      @words[category][word] ||= 0
      @words[category][word] += count
      @total_words += count
      @categories_words[category] += count
    end
    
    @categories_documents[category] += 1
    @total_documents += 1
  end
  
  def probabilities(document)
    probabilities = Hash.new
    @words.each_key {|category| probabilities[category] = probability(category, document)}
    probabilities
  end
  
  def probability(category, document)
    document_probability(category, document) * category_probability(category)
  end
  
  def document_probability(category, document)
    doc_prob = 1
    word_count(document).each {|word| doc_prob *= word_probability(category, word[0])}
    doc_prob
  end
  
  def word_probability(category, word)
    (@words[category][word.stem].to_f + 1)/@categories_words[category].to_f
  end
  
  def category_probability(category)
    @categories_documents[category].to_f/@total_documents.to_f
  end
  
  def classify(document, default='unknown')
    sorted = probabilities(document).sort {|a,b| a[1] <=> b[1]}
    best, second_best = sorted.pop, sorted.pop
    return best[0] if (best[1]/second_best[1] > @threshold)
  end
end