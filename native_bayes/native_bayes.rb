class NativeBayes
  def initialize(*categories)
    @words = Hash.new
    @total_words = 0
    @categories_documents = Hash.new
    @total_documents = 0
    @categories_words = Hash.new
    @threshold = 1.5 # wat
    
    categories.each do |category|
      @words[category] = Hash.new
      @categories_documents[category] = 0
      @categories_words[category] = 0
    end
  end
end