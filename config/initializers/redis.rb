# host 使用 localhost -> Error connecting to Redis on localhost:6379 (Redis::TimeoutError)
$redis = Redis.new(:host => '127.0.0.1', :port => 6379)