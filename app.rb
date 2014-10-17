require 'sinatra'
require './helpers/naming_helpers'
require './helpers/redis_helpers'

class DeployStatus < Sinatra::Base
  helpers NamingHelpers, RedisHelpers

  get '*' do
    erb :deploy_status, locals: { deploy_status: deploy_status }
  end

  post '/submit' do
    store(params)
  end

  def deploy_status
    status = {}
    servers.sort.each do |server|
      stat = server_status(server)
      status[server] = stat unless stat.empty?
    end
    status
  end

  run! if app_file == $0
end
