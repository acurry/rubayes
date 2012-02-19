require "#{Dir.pwd}/native_bayes/native_bayes_utils.rb"

class NativeBayes
  include NativeBayesUtils
  
  def initialize(*categories)
    @words = Hash.new
    @total_words = 0
    @categories_documents = Hash.new
    @total_documents = 0
    @categories_words = Hash.new
    @threshold = 1.5 # wat
    @list_of_categories = []
    
    categories.each do |category|
      add_category(category)
    end
  end
  
  def add_category(category)
    @list_of_categories << category
    @words[category] = Hash.new
    @categories_documents[category] = 0
    @categories_words[category] = 0
  end
  
  def train(category, document)
    add_category(category) unless @list_of_categories.include? category
    
    word_count(document).each do |word, count|
      @words[category][word] ||= 0
      @words[category][word] += count
      @total_words += count
      @categories_words[category] += count
    end
    
    @categories_documents[category] += 1
    @total_documents += 1
  end
end