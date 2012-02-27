require "stemmer/porter"
require_relative "../spec/mock_redis"
require_relative "../rubayes/rubayes"

describe Rubayes do  
  describe "train" do
    before :each do
      @nb = Rubayes.new
      @nb.redis = MockRedis.new
      @dummy_spam_category = "spam"
      @dummy_nonspam_category = "tech"
      @dummy_spam_doc = "Get money rich quick via big viagra member!"
      @dummy_nonspam_doc = "Google released their new API for Gmail and Gmaps"
    end
    
    it "should increment the document counter for the category by 1" do
      @nb.categories_documents = @dummy_spam_category, 0
      @nb.train(@dummy_spam_category, @dummy_spam_doc)
      @nb.categories_documents(@dummy_spam_category).should eq 1
    end
    
    it "should increment the total number of documents by 1" do
      @nb.total_documents.should eq 0
      @nb.train(@dummy_spam_category, @dummy_spam_doc)
      @nb.total_documents.should eq 1
    end
    
    context "for each word in the document" do
      it "should initialize the category's word's count to zero if it hasn't been initialized" do
        @nb.words_categories_word = @dummy_spam_category, "rich", 0
        @nb.words_categories_word(@dummy_spam_category, "rich").should eq 0
      end
      
      it "should add to the category's word's count" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.words_categories_word(@dummy_spam_category, "rich").should eq 1
      end
      
      it "should increment the total word count by the count of the current word" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.total_words.should eq 6
      end
      
      it "should add to the total of distinct words in the category" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.categories_words(@dummy_spam_category).should eq 6
      end
    end
  end
  
  describe "word_probability" do
    before :each do
      @nb = Rubayes.new
      @nb.redis = MockRedis.new
      @dummy_tech = "google apple java cool"
      @dummy_spam = "big money get rich quick via viagra penis member enlargment"
      ["tech", "spam"].each {|category| @nb.add_category(category)}
      @nb.train("tech", @dummy_tech)
      @nb.train("spam", @dummy_spam)
    end
    
    # (1 + 1) occurences of the word "google" in all 4 tech document words
    # 2 / 4 = 0.5
    it "should compute the probability of the word in a category" do
      @nb.word_probability("tech", "google".stem).should eq 0.5
    end
    
    # (0 + 1) occurences of the word "google" in all 8 spam document words
    # 1 / 8 = 0.125
    it "should compute the probability of the word in a category, even if the word does not exist" do
      @nb.word_probability("spam", "google".stem).should eq 0.125
    end
  end
  
  describe "category_probability" do
    before :each do
      @nb = Rubayes.new
      @nb.redis = MockRedis.new
      @dummy_tech = "google apple java cool"
      @dummy_spam = "big money get rich quick via viagra penis member enlargment"
      ["tech", "spam"].each {|category| @nb.add_category(category)}
      @nb.train("tech", @dummy_tech)
      @nb.train("spam", @dummy_spam)
      @nb.train("business", @dummy_tech)
      @nb.train("computers", @dummy_tech)
    end
    
    it "should compute the probability of a document being in a particular category" do
      @nb.category_probability("tech").should eq 0.25
    end
  end
end