class DbConnection
  attr_accessor :host, :port
  def initialize(*args)
    if args
      @host = args[0]
      @port = args[1]
    end
  end
end