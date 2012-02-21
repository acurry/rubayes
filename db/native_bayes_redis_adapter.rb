require 'redis'
require_relative '../native_bayes/native_bayes'
require_relative 'native_bayes_redis_keyset'

DEFAULT_REDIS_HOST = "127.0.0.1"
DEFAULT_REDIS_PORT = 6379

class NativeBayesRedisAdapter
  include NativeBayesRedisKeyset
  
  def initialize(host=DEFAULT_REDIS_HOST, port=DEFAULT_REDIS_PORT)
    @redis = Redis.new(:host=>host, :port=>port)
  end
  
  def categories
    @redis.smembers set_of_categories_key
  end
  
  def add_to_set_of_categories(category)
    @redis.sadd set_of_categories_key, category
  end
  
  def set_words_category_word_count(category, word, count)
    @redis.hset(words_category_hash_key(category), word, count)
  end
  
  def increment_total_words_by(value)
    @redis.incrby(total_words_key, value)
  end
  
  def increment_total_documents_by(value)
    @redis.incrby(total_documents_key, value)
  end
  
  def increment_categories_documents_for_category_by(category, value)
    @redis.hincrby(categories_documents_key, category, value)
  end
end
