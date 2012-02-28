require "redis"
require "mock_redis"
require_relative "../db/redis_db_adapter"

describe RedisDbAdapter do  
  before :each do
    @redis = RedisDbAdapter.new
    @redis.redis = MockRedis.new
    @redis.redis.select(15)
    @redis.redis.flushdb
  end
  
  after :each do
    @redis.redis.flushdb
  end
  
  describe "set and get" do
    it "should set and get the key & value" do
      @redis.get("foo").should eq ""
      @redis.set("foo", "bar")
      @redis.get("foo").should eq "bar"
    end
  end
  
  describe "incr and decr" do
    it "should increment and decrement an integer value" do
      @redis.get("foo_int").should eq ""
      @redis.set("foo_int", 0)
      @redis.incrby("foo_int", 1)
      @redis.get("foo_int").should eq 1.to_s
      @redis.decrby("foo_int", 1)
      @redis.get("foo_int").should eq 0.to_s
    end
  end
  
  describe "hash_set and hash_get" do
    it "should set and get the hash via key and field" do
      @redis.hash_get("foo_hash", "field").should eq "0"
      @redis.hash_set("foo_hash", "field", "bar")
      @redis.hash_get("foo_hash", "field").should eq "bar"
    end
  end
end
