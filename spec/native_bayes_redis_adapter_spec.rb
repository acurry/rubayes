require 'redis'
require_relative '../db/native_bayes_redis_adapter'

class NativeBayesRedisAdapter; attr_reader :redis; end

describe NativeBayesRedisAdapter do
  before :each do
    @nbra = NativeBayesRedisAdapter.new
    @nbra.redis.select(15)
    @nbra.redis.flushdb
  end
  
  describe "initialize" do
    it "should create a new instance of a Redis client" do
      @nbra.redis.should be_an_instance_of Redis
    end
  end
  
  describe "categories" do
    it "should get the current set of categories" do
      @nbra.redis.sadd(@nbra.set_of_categories_key,"cat1")
      @nbra.redis.sadd(@nbra.set_of_categories_key,"cat2")
      @nbra.categories.should eq ["cat1", "cat2"]
    end
  end
  
  describe "set_words_category_word_count" do
    it "should set the words_category_word counter to value" do
      @nbra.set_words_category_word_count("tech", "google", 1)
      @nbra.redis.hget(@nbra.words_category_hash_key("tech"), "google").should eq 1.to_s
    end
  end
  
  describe "increment_total_words_by" do
    it "should increment @total_words by count" do
      @nbra.increment_total_words_by(3)
      @nbra.redis.get(@nbra.total_words_key).should eq 3.to_s
    end
  end
  
  describe "increment_total_documents_by" do
    it "should increment @total_documents by count" do
      @nbra.increment_total_documents_by(6)
      @nbra.redis.get(@nbra.total_documents_key).should eq 6.to_s
    end
  end
  
  # redis.hincrby key, field, increment
  describe "increment_categories_documents_for_category_by" do
    it "should increment @categories_documents[<category>] by count" do
      @nbra.increment_categories_documents_for_category_by("spam", 2)
      @nbra.redis.hget(@nbra.categories_documents_key, "spam").should eq 2.to_s
    end
  end

  # redis.hincrby key, field, increment  
  describe "increment_categories_words_for_category_by" do
    it "should increment @categories_words[<category>] by count"
  end
  
  # redis.hincrby key, field, increment
  describe "increment_words_categories_for_word_by" do
    it "should increment @words[<category>][<word>] by count"
  end
end