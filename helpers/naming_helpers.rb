module NamingHelpers
  REPO_MAP = {}

  APP_MAP = {
    "id-web" => "compose",
    "cbe-web" => "cognify"
  }

  SERVER_MAP = {
    "qa-cbe1" => "qa 1",
    "qa-cbe2" => "qa 2",
    "mdev-cbe1" => "mdev",
    "mqa-cbe1" => "mqa",
    "sdev-cbe1" => "sdev",
    "sqa-cbe1" => "sqa",
    "prod-cbe1" => "prod 1",
    "prod-cbe2" => "prod 2"
  }

  def app_name(app)
    APP_MAP.fetch(app, app)
  end

  def server_name(server_name)
    SERVER_MAP.fetch(server_name, server_name)
  end

  def repo_name(repo_name)
    REPO_MAP.fetch(repo_name, repo_name)
  end
end

