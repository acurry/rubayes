require_relative "../rubayes/rubayes"

# make getters & setters in order to test
# Rubayes attributes
class Rubayes; attr_accessor :db; end

describe Rubayes do  
  describe "train" do
    before :each do
      @nb = Rubayes.new
      @nb.db.redis = MockRedis.new
      @dummy_spam_category = "spam"
      @dummy_nonspam_category = "tsech"
      @dummy_spam_doc = "Get money rich quick via big viagra member!"
      @dummy_nonspam_doc = "Google released their new API for Gmail and Gmaps"
    end
    
    context "for each word in the document" do
      it "should initialize the word's count for the category to zero if it hasn't been initialized" do
        @nb.db.words_categories_word = @dummy_spam_category, "rich", 0
        @nb.db.words_categories_word(@dummy_spam_category, "rich").should eq 0
      end
      
      it "should add the count for each word in the document to the word's total count in the words[cat] hash" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.db.words_categories_word(@dummy_spam_category, "rich").should eq 1
      end
      
      it "should increment the total word count by the count of the current word" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.db.total_words.should eq 6
      end
      
      it "should add the total count of distinct words for the category in the hash of word categories" do
        @nb.train(@dummy_spam_category, @dummy_spam_doc)
        @nb.db.categories_words(@dummy_spam_category).should eq 6
      end
    end
    
    it "should increment the document counter for the category by 1" do
      @nb.db.categories_documents = @dummy_spam_category, 0
      @nb.train(@dummy_spam_category, @dummy_spam_doc)
      @nb.db.categories_documents(@dummy_spam_category).should eq 1
    end
    
    it "should increment the total number of documents by 1" do
      @nb.db.total_documents.should eq 0
      @nb.train(@dummy_spam_category, @dummy_spam_doc)
      @nb.db.total_documents.should eq 1
    end
  end
  
  describe "word_probability" do
    before :each do
      @nb = Rubayes.new
      @nb.db.redis = MockRedis.new
      @dummy_tech = "google apple java cool"
      @dummy_spam = "big money get rich quick via viagra penis member enlargment"
      ["tech", "spam"].each {|category| @nb.db.add_category(category)}
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
      @nb.db.redis = MockRedis.new
      @dummy_tech = "google apple java cool"
      @dummy_spam = "big money get rich quick via viagra penis member enlargment"
      ["tech", "spam"].each {|category| @nb.db.add_category(category)}
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