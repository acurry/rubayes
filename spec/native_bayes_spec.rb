require "#{Dir.pwd}/native_bayes/native_bayes.rb"

# make getters & setters in order to test
# NativeBayes attributes
class NativeBayes
  attr_accessor :words, :total_words
  attr_accessor :categories_documents, :total_documents
  attr_accessor :categories_words, :threshold
end

describe NativeBayes do
  context "when constructed should have" do
    before :each do
      @dummy_category = 'spam'
      @native_bayes = NativeBayes.new(@dummy_category)
    end
    
    it "@words, a hash" do
      @native_bayes.words.should be_an_instance_of Hash
    end
    
    it "@total_words, an integer" do
      @native_bayes.total_words.should be_an_instance_of Fixnum
      @native_bayes.total_words.should eq 0
    end
    
    it "@categories_document, a hash" do
      @native_bayes.categories_documents.should be_an_instance_of Hash
    end
    
    it "@total_documents, an integer" do
      @native_bayes.total_documents.should be_an_instance_of Fixnum
      @native_bayes.total_documents.should eq 0
    end
    
    it "@categories_words, a hash" do
      @native_bayes.categories_words.should be_an_instance_of Hash
    end
    
    it "@threshold, a float" do
      @native_bayes.threshold.should be_an_instance_of Float
      @native_bayes.threshold.should eq 1.5
    end
    
    context "and given a single category, '#{@dummy_category}', as a parameter" do
      it "should make a new hash at @words['spam']" do
        @native_bayes.words[@dummy_category].should be_an_instance_of Hash
      end
      
      it "should set @categories_documents['#{@dummy_category}'] to zero" do
        @native_bayes.categories_documents[@dummy_category].should eq 0
      end
      
      it "should set @categories_words['#{@dummy_category}'] to zero" do
        @native_bayes.categories_words[@dummy_category].should eq 0
      end
    end
  end
  
  
end