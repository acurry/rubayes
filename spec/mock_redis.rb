class MockRedis
  attr_accessor :redis
  
  def initialize
    @redis = {}
  end
  
  def flushdb
    @redis = {}
  end
  
  def select(value)
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
  
  def hset(key, field, value)
    @redis[key] ||= {}
    @redis[key][field] = value
  end
  
  def hget(key, field)
    @redis[key] ||= {}
    @redis[key][field] ||= 0
    @redis[key][field].to_s
  end
  
  def hgetall(key)
    @redis[key] ||= {}
    @redis[key]
  end
  
  def incrby(key, value)
    @redis[key] ||= 0
    @redis[key] += value
  end
  
  def hincrby(key, field, value)
    @redis[key] ||= {}
    @redis[key][field] ||= 0
    @redis[key][field] += value
  end

  def decrby(key, value)
    @redis[key] ||= 0
    @redis[key] -= value
  end

  def hincrby(key, field, value)
    @redis[key] ||= {}
    @redis[key][field] ||= 0
    @redis[key][field] -+ value
  end
end
