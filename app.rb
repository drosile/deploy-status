require 'sinatra'
require 'json'
require './helpers/naming_helpers'
require './helpers/redis_helpers'

class DeployStatus < Sinatra::Base
  helpers NamingHelpers, RedisHelpers

  get '/server/:server_name' do
    hostnames = matched_hostnames(params[:server_name]) || [params[:server_name]]
    erb :deploy_status, locals: { deploy_status: deploy_status(hostnames) }
  end

  get '/api/server/:server_name' do
    hostnames = matched_hostnames(params[:server_name]) || [params[:server_name]]
    content_type :json
    deploy_status(hostnames).to_json
  end

  get '*' do
    erb :deploy_status, locals: { deploy_status: deploy_status }
  end

  post '/submit' do
    store(params)
  end

  def deploy_status(hosts = [])
    status = {}
    hosts = servers if hosts.empty?
    hosts.sort.each do |server|
      stat = server_status(server)
      status[server] = stat unless stat.empty?
    end
    status
  end

  def matched_hostnames(server_name)
    matched_servers = SERVER_MAP.select do |k, v|
      v.start_with? server_name.split.first
    end

    matched_servers.keys unless matched_servers.empty?
  end

  run! if app_file == $0
end
