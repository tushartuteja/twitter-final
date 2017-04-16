Redis.current = Redis.new(:host => "127.0.0.1", :port => "6379", :thread_safe => true)
Resque.redis = Redis.current