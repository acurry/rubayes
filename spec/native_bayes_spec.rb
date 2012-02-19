require "#{Dir.pwd}/native_bayes/native_bayes.rb"

# make getters & setters in order to test
# NativeBayes attributes
class NativeBayes
  attr_accessor :words, :total_words
  attr_accessor :categories_documents, :total_documents
  attr_accessor :categories_words, :threshold, :set_of_categories
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
  
  describe "add_category" do
    before :each do
      @nb = NativeBayes.new
      @dummy_category = "dummy"
      @nb.add_category(@dummy_category)
    end
    
    it "should add category to @set_of_categories" do
      @nb.set_of_categories.should include(@dummy_category)
    end
    
    it "should initialize @words[category] to a new hash" do
      @nb.words[@dummy_category].should be_an_instance_of Hash
    end
    
    it "should initialize @categories_documents[category] to zero" do
      @nb.categories_documents[@dummy_category].should eq 0
    end
    
    it "should initialize @categories_words[category] to zero" do
      @nb.categories_words[@dummy_category].should eq 0
    end
  end
  
  describe "train" do
    before :each do
      @nb = NativeBayes.new
      @dummy_spam_category = "spam"
      @dummy_nonspam_category = "tech"
      @dummy_spam_doc = "Get money rich quick via big viagra member!"
      @dummy_nonspam_doc = "Google released their new API for Gmail and Gmaps"
    end
    
    it "should add the category to the set of existing categories if it does not exist" do
      @nb.set_of_categories.should_not include(@dummy_spam_category)
      @nb.train(@dummy_spam_category, @dummy_spam_doc)
      @nb.set_of_categories.should include(@dummy_spam_category)
    end
    
    context "for each word in the document" do
      it "should initialize the word's count for the category to zero if it hasn't been initialized" do
        @nb.add_category(@dummy_spam_category)
        @nb.words[@dummy_spam_category]["rich"].should eq nil
      end
      
      it "should add the total count for each word in the document to the word's total count in the hash of categorized words" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.words[@dummy_spam_category]["rich"].should eq 1
      end
      
      it "should increment the total word count by the count of the current word" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.total_words.should eq 6
      end
      
      it "should add the total count of distinct words for the category in the hash of word categories" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.categories_words[@dummy_spam_category].should eq 6
      end
    end
    
    it "should increment the document counter for the category by 1" do
      @nb.categories_documents[@dummy_spam_category].should eq nil
      @nb.train(@dummy_spam_category, @dummy_spam_doc)
      @nb.categories_documents[@dummy_spam_category].should eq 1
    end
    
    it "should increment the total number of documents by 1" do
      @nb.total_documents.should eq 0
      @nb.train(@dummy_spam_category, @dummy_spam_doc)
      @nb.total_documents.should eq 1
    end
  end
end