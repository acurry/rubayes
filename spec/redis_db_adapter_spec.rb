require "redis"
require_relative "../db/redis_db_adapter"

describe RedisDbAdapter do  
  before :each do
    @redis = RedisDbAdapter.new
    @redis.redis.select(15)
    @redis.redis.flushdb
  end
  
  after :each do
    @redis.redis.flushdb
  end
  
  describe "initialize" do
    context "given no parameters" do
      it "should initialize a new base Redis client with default parameters" do
        redis = RedisDbAdapter.new
        redis.host.should eq DEFAULT_REDIS_HOST
        redis.port.should eq DEFAULT_REDIS_PORT
      end
    end
    
    context "given host parameter" do
      it "should initialize a new base Redis client using specified host and default port" do
        redis = RedisDbAdapter.new("redis_host")
        redis.host.should eq "redis_host"
      end
    end
    
    context "given host and port parameters" do
      it "should initialize a new base Redis client using specified host and specified port" do
        redis = RedisDbAdapter.new("redis_host", 6000)
        redis.host.should eq "redis_host"        
        redis.port.should eq 6000
      end
    end
  end
  
  describe "set and get" do
    it "should set and get the key & value" do
      @redis.get("foo").should be_nil
      @redis.set("foo", "bar")
      @redis.get("foo").should eq "bar"
    end
  end
  
  describe "incr and decr" do
    it "should increment and decrement an integer value" do
      @redis.get("foo_int").should be_nil
      @redis.set("foo_int", 0)
      @redis.incr("foo_int")
      @redis.get("foo_int").should eq 1.to_s
      @redis.decr("foo_int")
      @redis.get("foo_int").should eq 0.to_s
    end
  end
  
  describe "hash_set and hash_get" do
    it "should set and get the hash via key and field" do
      @redis.hash_get("foo_hash", "field").should be_nil
      @redis.hash_set("foo_hash", "field", "bar")
      @redis.hash_get("foo_hash", "field").should eq "bar"
    end
  end
end