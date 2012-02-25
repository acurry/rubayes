require 'redis'

class RedisDbAdapter
  attr_accessor :redis, :config  
  def initialize(host="127.0.0.1", port=6379)
    @redis = Redis.new(:host=>host, :port=>port)
  end
  
  def host
    @redis.client.host
  end
  
  def port
    @redis.client.port
  end
  
  def set(key, value)
    @redis.set(key, value)
  end
  
  def get(key)
    @redis.get(key)
  end
  
  def incr(key)
    @redis.incr(key)
  end
  
  def decr(key)
    @redis.decr(key)
  end
  
  def hash_get(key, field)
    @redis.hget(key, field)
  end
  
  def hash_set(key, field, value)
    @redis.hset(key, field, value)
  end
end