class MockRedis
  attr_accessor :redis
  
  def initialize
    @redis = {}
  end
  
  def set(key, value)
    @redis[key] = value
  end
  
  def get(key)
    @redis[key].to_s
  end
  
  def sadd(key, value)
    @redis[key] ||= []
    @redis[key] << value
  end
  
  def smembers(key)
    @redis[key]
  end
  
  def hset(field, key, value)
    @redis[field] ||= {}
    @redis[field][key] = value
  end
  
  def hget(field, key)
    @redis[field][key].to_s
  end
  
  def incrby(key, value)
    @redis[key] ||= 0
    @redis[key] += value
  end
  
  def hincrby(field, key, value)
    @redis[field] ||= {}
    @redis[field][key] ||= 0
    @redis[field][key] += value
  end
end