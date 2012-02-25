require 'set'
require 'pp'
require_relative "rubayes_utils"
require_relative "../db/rubayes_redis_adapter"

class Rubayes
  include RubayesUtils
  attr_reader :db
  
  def initialize(static=true)
    @db = RubayesRedisAdapter.new
    @db.flushdb if static        
  end
  
  def train(category, document)
    @db.add_category(category)
    
    word_count(document).each do |word, count|
      @db.increment_words_categories_word(category, word, count)
      @db.total_words += count
      @db.increment_categories_words(category, count)
    end
    
    @db.increment_categories_documents(category, 1)
    @db.total_documents += 1
  end
  
  def probabilities(document)
    probabilities = Hash.new
    
    @db.words.each_key do |category| 
      pp category
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
    ((@db.words_categories_word(category, word) + 1.0).to_f)/@db.categories_words(category).to_f
  end
  
  def category_probability(category)
    @db.categories_documents(category).to_f/@db.total_documents.to_f
  end
  
  def classify(document, default='unknown')
    sorted = probabilities(document).sort {|a,b| a[1] <=> b[1]}
    best, second_best = sorted.pop, sorted.pop
    return best[0] if (best[1]/second_best[1] > @db.threshold)
  end
end