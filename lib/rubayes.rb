require 'set'
require_relative "rubayes_utils"
require_relative "../db/rubayes_redis_adapter"

class Rubayes
  include RubayesUtils
  include RubayesRedisAdapter
  
  def initialize(static=true)       
    super()
    flushdb if static
  end
  
  def train(category, document)
    add_category(category)
    word_count(document).each do |word, count|
      increment_words_categories_word(category, word, count)
      increment_total_words count
      increment_categories_words(category, count)
    end
    increment_categories_documents(category, 1)
    increment_total_documents 1
  end
  
  def probabilities(document)
    probabilities = Hash.new
    words.each_key do |category| 
      probabilities[category] = probability(category, document)
    end
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
    ((words_categories_word(category, word) + 1.0).to_f)/categories_words(category).to_f
  end
  
  def category_probability(category)
    categories_documents(category).to_f/total_documents.to_f
  end
  
  def classify(document, default='unknown')
    sorted = probabilities(document).sort {|a,b| a[1] <=> b[1]}
    best, second_best = sorted.pop, sorted.pop
    return best[0] if (best[1]/second_best[1] > threshold)
  end
end