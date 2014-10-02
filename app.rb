require 'sinatra'
require 'redis'

DELIM = '☃'
SECRET = ENV['SECRET']

redis_uri = ENV['REDISTOGO_URL'] || 'redis://localhost:6379'
uri = URI.parse(redis_uri)
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)

get '*' do
  status_to_html(deploy_status)
end

post '/submit' do
  store(params)
end

def validate_params(params)
  params[:server] && params[:repo] && params[:tag] && params[:sha] &&
    params[:user] && params[:secret] && params[:secret] == SECRET
end

def store(params)
  return unless validate_params(params)
  key = [params[:server], params[:repo]].join(DELIM)
  REDIS.hset(key, "tag", params[:tag])
  REDIS.hset(key, "sha", params[:sha])
  REDIS.hset(key, "date", Time.now)
  REDIS.hset(key, "deployer", params[:user])
  "success"
end

def server_status(server_name)
  status = {}
  REDIS.keys("#{server_name}#{DELIM}*").each do |key|
    repo = key.split(DELIM)[-1]
    status[repo] = REDIS.hgetall(key)
  end
  status
end

def servers
  REDIS.keys.map { |key| key.split(DELIM).first }
end

def deploy_status
  status = {}
  servers.each do |server|
    stat = server_status(server)
    status[server] = stat unless stat.empty?
  end
  status
end

def status_to_html(deploy_status)
  html = ["<html>\n",
          "<head>\n<link rel='stylesheet' type='text/css' href='style.css'>\n",
          "<title>Deploy status</title>\n</head>\n<body>"]
  deploy_status.each do |server, repos|
    html += ["<h2>#{server}</h2>\n",
             "<table>\n",
             "<th>repo</th>\n<th>tag</th>\n<th>hash</th>\n<th>date</th>\n<th>deployer</th>\n"]
    repos.each do |repo, deploy_data|
      html += ["<tr>",
               "<td>#{repo}</td>\n",
               "<td>#{deploy_data["tag"]}</td>\n",
               "<td><a href=\"https://github.com/flatworld/#{repo}/commit/#{deploy_data["sha"]}\">#{deploy_data["sha"]}</a></td>\n",
               "<td>#{deploy_data["date"]}</td>\n",
               "<td>#{deploy_data["deployer"]}</td>\n",
               "</tr>"]
    end
    html << "</table>\n"
  end
  html << "</body>\n</html>"
  html.join("")
end
