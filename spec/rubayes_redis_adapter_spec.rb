require 'mock_redis'
require_relative '../db/rubayes_redis_adapter'

class RubayesRedisAdapter; attr_accessor :redis; end

describe RubayesRedisAdapter do
  before :each do
    @rra = RubayesRedisAdapter.new
    @rra.redis = MockRedis.new
  end
  
  describe "categories" do
    it "should get the current set of categories" do
      @rra.redis.sadd(@rra.set_of_categories_key,"cat1")
      @rra.redis.sadd(@rra.set_of_categories_key,"cat2")
      @rra.categories.should eq ["cat1", "cat2"]
    end
  end
  
  describe "set_words_category_word_count" do
    it "should set the words_category_word counter to value" do
      @rra.set_words_category_word_count("tech", "google", 1)
      @rra.redis.hget(@rra.words_category_hash_key("tech"), "google").should eq 1.to_s
    end
  end
  
  describe "increment_total_words_by" do
    it "should increment the total number of words by count" do
      @rra.increment_total_words_by(3)
      @rra.redis.get(@rra.total_words_key).should eq 3.to_s
    end
  end
  
  describe "increment_total_documents_by" do
    it "should increment the total number of documents by count" do
      @rra.increment_total_documents_by(6)
      @rra.redis.get(@rra.total_documents_key).should eq 6.to_s
    end
  end
  
  # redis.hincrby key, field, increment
  describe "increment_categories_documents_for_category_by" do
    it "should increment @categories_documents[<category>] by count" do
      @rra.increment_categories_documents_for_category_by("spam", 2)
      @rra.redis.hget(@rra.categories_documents_key, "spam").should eq 2.to_s
    end
  end

  # redis.hincrby key, field, increment  
  describe "increment_categories_words_for_category_by" do
    it "should increment @categories_words[<category>] by count" do
      @rra.increment_categories_words_for_category_by("spam", 10)
      @rra.redis.hget(@rra.categories_words_key, "spam").should eq 10.to_s
    end
  end
  
  # redis.hincrby key, field, increment
  describe "increment_words_categories_for_word_by" do
    it "should increment @words[<category>][<word>] by count" do
      @rra.increment_words_categories_for_category_and_word_by("spam", "viagra", 20)
      @rra.redis.hget(@rra.words_category_hash_key("spam"), "viagra").should eq 20.to_s
    end
  end
  
  describe "total_words" do
    it "should get the total word count" do
      @rra.increment_total_words_by(4)
      @rra.total_words.should eq 4.to_s
    end
  end
  
  describe "total_documents" do
    it "should get the total document count" do
      @rra.increment_total_documents_by(6)
      @rra.total_documents.should eq 6.to_s
    end
  end
  
  describe "categories_documents" do
    it "should get the count of documents in the specified category" do
      @rra.increment_categories_documents_for_category_by("music", 2)
      @rra.categories_documents("music").should eq 2.to_s
    end
  end
  
  describe "categories_words" do
    it "should get the count of words in the specified category" do
      @rra.increment_categories_words_for_category_by("odd", 20)
      @rra.categories_words("odd").should eq 20.to_s
    end
  end
  
  describe "words_categories_category" do
    it "should get the count of the specified word in the specified category" do
      @rra.increment_words_categories_for_category_and_word_by("obit", "death", 3)
      @rra.words_categories_category("obit", "death").should eq 3.to_s
    end
  end
end