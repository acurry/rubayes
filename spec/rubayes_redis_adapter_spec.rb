require 'mock_redis'
require_relative '../db/rubayes_redis_adapter'

module RubayesRedisAdapter; attr_accessor :redis; end
class DummyRubayesRedisAdapter; include RubayesRedisAdapter; end

describe RubayesRedisAdapter do
  before :each do
    @rra = DummyRubayesRedisAdapter.new
    @rra.redis = MockRedis.new
  end
  
  describe "categories" do
    it "should get the current set of categories" do
      @rra.redis.sadd(@rra.set_of_categories_key,"cat1")
      @rra.redis.sadd(@rra.set_of_categories_key,"cat2")
      @rra.categories.should eq ["cat1", "cat2"]
    end
  end
  
  describe "add_category" do
    it "should add the category to categories" do
      @rra.add_category("cat3")
      @rra.add_category("cat4")
      @rra.redis.smembers(@rra.set_of_categories_key).should eq ['cat3', 'cat4']
    end
  end
  
  describe "words" do
    it "should return the hash of all words and their counts in the specified category" do
      @rra.words_categories_word = "lifestyle", "decorating", 11
      @rra.words_categories_word = "lifestyle", "harto", 22
      @rra.add_category("lifestyle")
      @rra.words.should eq({"lifestyle" => {"decorating" => 11, "harto" => 22}})
    end
  end
  
  describe "increment_categories_documents" do
    it "should increment @categories_documents[<category>] by count" do
      @rra.increment_categories_documents("spam", 2)
      @rra.redis.hget(@rra.categories_documents_key, "spam").should eq 2.to_s
    end
  end

  describe "increment_categories_words" do
    it "should increment @categories_words[<category>] by count" do
      @rra.increment_categories_words("spam", 10)
      @rra.redis.hget(@rra.categories_words_key, "spam").should eq 10.to_s
    end
  end
  
  describe "increment_words_categories_word" do
    it "should increment @words[<category>][<word>] by count" do
      @rra.increment_words_categories_word("spam", "viagra", 20)
      @rra.redis.hget(@rra.words_category_hash_key("spam"), "viagra").should eq 20.to_s
    end
  end
  
  describe "total_words" do
    it "should get the total word count" do
      @rra.total_words = (4)
      @rra.total_words.should eq 4
    end
  end
  
  describe "total_documents" do
    it "should get the total document count" do
      @rra.total_documents = 6
      @rra.total_documents.should eq 6
    end
  end
  
  describe "categories_documents" do
    it "should get the count of documents in the specified category" do
      @rra.increment_categories_documents("music", 2)
      @rra.categories_documents("music").should eq 2
    end
  end
  
  describe "categories_words" do
    it "should get the count of words in the specified category" do
      @rra.increment_categories_words("odd", 20)
      @rra.categories_words("odd").should eq 20
    end
  end
  
  describe "words_categories_word" do
    it "should get the count of the specified word in the specified category" do
      @rra.increment_words_categories_word("obit", "death", 3)
      @rra.words_categories_word("obit", "death").should eq 3
    end
  end
  
  describe "total_words=" do
    it "should set the total word count" do
      @rra.total_words = 4
      @rra.total_words.should eq 4
    end
  end
  
  describe "total_documents=" do
    it "should set the total document count" do
      @rra.total_documents = 19
      @rra.total_documents.should eq 19
    end
  end
  
  describe "categories_documents=" do
    it "should set the category's document count" do
      @rra.categories_documents = "biz", 13
      @rra.categories_documents("biz").should eq 13
    end
  end
  
  describe "categories_words=" do
    it "should set the category's word count" do
      @rra.categories_words = "health", 23
      @rra.categories_words("health").should eq 23
    end
  end
  
  describe "words_categories_word=" do
    it "should set the category's word count" do
      @rra.words_categories_word = "health", "cancer", 23
      @rra.words_categories_word("health", "cancer").should eq 23
    end
  end
  
  describe "incrementing total_words" do
    context "when using total_words() and total_words=()" do
      it "should increment the total word count correctly" do
        @rra.total_words += 14
        @rra.total_words.should eq 14
      end
    end
  end
  
  describe "incrementing total_documents" do
    context "when using total_documents() and total_documents=()" do
      it "should increment the total document count correctly" do
        @rra.total_documents += 15
        @rra.total_documents.should eq 15
      end
    end
  end
end