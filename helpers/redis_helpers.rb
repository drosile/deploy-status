require 'redis'

module RedisHelpers
  DELIM = '☃'
  REDIS_URI = ENV['REDISTOGO_URL'] || 'redis://localhost:6379'
  SECRET = ENV['SECRET']
  GITHUB = 'https://github.com/sagence'

  def store(params)
    return unless validate_params(params)
    key = [params[:server], params[:repo]].join(DELIM)
    redis.hset(key, "tag", params[:tag])
    redis.hset(key, "sha", params[:sha])
    redis.hset(key, "date", Time.now)
    redis.hset(key, "deployer", params[:user])
    "success"
  end

  def server_status(hostname)
    status = {}
    redis.keys("#{hostname}#{DELIM}*").sort.each do |key|
      repo = key.split(DELIM)[-1]
      status[repo] = redis.hgetall(key)
    end
    status
  end

  def servers
    redis.keys.map { |key| key.split(DELIM).first }
  end

  def keys(key_str)
    redis.keys(key_str)
  end

  def remove_keys(key_str)
    keys(key_str).each do |key|
      redis.del(key)
    end
  end

  private

  def validate_params(params)
    params[:server] && params[:repo] && params[:tag] && params[:sha] &&
      params[:user] && params[:secret] && params[:secret] == SECRET
  end

  def redis
    @redis ||= Redis.new(host: redis_uri.host,
                          port: redis_uri.port,
                          password: redis_uri.password)
  end

  def redis_uri
    URI.parse(REDIS_URI)
  end
end
