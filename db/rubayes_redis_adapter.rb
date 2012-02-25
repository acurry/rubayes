require 'redis'
require_relative '../rubayes/rubayes'
require_relative 'rubayes_redis_keyset'

DEFAULT_REDIS_HOST = "127.0.0.1"
DEFAULT_REDIS_PORT = 6379

class RubayesRedisAdapter
  include RubayesRedisKeyset
  
  def initialize(host=DEFAULT_REDIS_HOST, port=DEFAULT_REDIS_PORT)
    @redis = Redis.new(:host=>host, :port=>port)
  end
  
  def threshold
    @redis.get(threshold_key).to_f
  end
  
  def threshold=(value)
    @redis.set(threshold_key, value)
  end
  
  def categories
    @redis.smembers set_of_categories_key
  end
  
  def add_category(category)
    @redis.sadd set_of_categories_key, category
  end
  
  def words
    words_categories = {}
    categories.each do |category|
      words_categories[category] = @redis.hgetall words_category_hash_key(category)
    end
    words_categories
  end
  
  def total_words
    @redis.get(total_words_key).to_i
  end
  
  def total_documents
    @redis.get(total_documents_key).to_i
  end
  
  def categories_documents(category)
    @redis.hget(categories_documents_key, category).to_i
  end
  
  def categories_words(category)
    @redis.hget(categories_words_key, category).to_i
  end
  
  def words_categories_word(category, word)
    @redis.hget(words_category_hash_key(category), word).to_i
  end
  
  def total_words=(value)
    @redis.set(total_words_key, value)
  end
  
  def total_documents=(value)
    @redis.set(total_documents_key, value)
  end
  
  def categories_documents=(args)
    @redis.hset(categories_documents_key, args[0], args[1])
  end
  
  def categories_words=(args)
    @redis.hset(categories_words_key, args[0], args[1])
  end
  
  def words_categories_word=(args)
    @redis.hset(words_category_hash_key(args[0]), args[1], args[2])
  end
  
  def increment_categories_documents(category, value)
    @redis.hincrby(categories_documents_key, category, value)
  end
  
  def increment_categories_words(category, value)
    @redis.hincrby(categories_words_key, category, value)
  end
  
  def increment_words_categories_word(category, word, value)
    @redis.hincrby(words_category_hash_key(category), word, value)
  end
end
