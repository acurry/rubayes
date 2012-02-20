require 'redis'

DEFAULT_REDIS_HOST = "127.0.0.1"
DEFAULT_REDIS_PORT = 6379

class RedisDbAdapter
  attr_accessor :redis, :config  
  def initialize(host=DEFAULT_REDIS_HOST, port=DEFAULT_REDIS_PORT)
    @redis = Redis.new(:host=>host, :port=>port)
  end
  
  def set(key, value)
    @redis.set(key, value)
  end
  
  def get(key)
    @redis.get(key)
  end
end