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
  
  def categories
    @redis.smembers set_of_categories_key
  end
  
  def add_to_set_of_categories(category)
    @redis.sadd set_of_categories_key, category
  end
  
  def set_categorized_word_count(category, word, count)
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
  
  def increment_categories_words_for_category_by(category, value)
    @redis.hincrby(categories_words_key, category, value)
  end
  
  def increment_words_categories_for_category_and_word_by(category, word, value)
    @redis.hincrby(words_category_hash_key(category), word, value)
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
end