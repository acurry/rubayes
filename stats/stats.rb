class Event
  include Enumerable
  
  attr_accessor :a, :b, :name  
  
  def initialize (a=0.0, b=1.0, name="event")
    @a, @b, @name = a, b, name
  end

  def a
    @a.to_f
  end
  
  def b
    @b.to_f
  end
  
  def a=(a)
    @a = a.to_f
  end
  
  def b=(b)
    @b = b.to_f
  end

  def to_s
    "[#{name}] : #{a}/#{b} : #{"0.3f" % p}"
  end
  
  def success
    (@a / @b.to_f)
  end
  
  def probability
    success
  end
  
  def p
    success
  end
end

class Series
  include Enumerable
  attr_accessor :events
  
  def initialize (events=[], count=0)
    @events, @count = events, count
  end
  
  def each &block
    @events.each {|member| block.call(member)}
  end
  
  def count
    @events.count
  end
  
  def << (event)
    @events << event
  end
    
  def successes
    self.map{|event| event.success}
  end
  
  def success
    self.successes.inject {|product, success| product * success}
  end
  
  def [](index)
    @events[index]
  end
  
  def to_s
    @events.map {|e| e.to_s}
  end
end

