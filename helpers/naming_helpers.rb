module NamingHelpers
  REPO_MAP = {
    "admin-web" => "id-web",
    "comp-web" => "cbe-web"
  }

  SERVER_MAP = {
    "dev-cbeserver1.flatworldknowledge.com" => "dev",
    "mqa-cbeserver1.flatworldknowledge.com" => "mqa",
    "mtqa-cbeserver1.flatworld.com" => "qa 1",
    "mtqa-cbeserver2.flatworld.com" => "qa 2",
    "mtprod-cbeserver1.flatworld.com" => "prod 1",
    "mtprod-cbeserver2.flatworld.com" => "prod 2"
  }

  def server_name(server_name)
    SERVER_MAP.fetch(server_name, server_name)
  end

  def repo_name(repo_name)
    REPO_MAP.fetch(repo_name, repo_name)
  end
end

