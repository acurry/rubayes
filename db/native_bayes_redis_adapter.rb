require 'redis'
require_relative '../native_bayes/native_bayes'
require_relative 'native_bayes_redis_keyset'

DEFAULT_REDIS_HOST = "127.0.0.1"
DEFAULT_REDIS_PORT = 6379

class NativeBayesRedisAdapter
  include NativeBayesRedisKeyset
  
  def initialize(host=DEFAULT_REDIS_HOST, port=DEFAULT_REDIS_PORT)
    @client = Redis.new(:host=>host, :port=>port)
  end
  
  
end
