module NamingHelpers
  REPO_MAP = {
    "admin-web" => "design",
    "comp-web" => "learn"
  }

  SERVER_MAP = {
    "dev-cbeserver1.flatworld.com" => "dev",
    "mqa-cbe1" => "mqa",
    "qa-cbe1" => "qa 1",
    "qa-cbe2" => "qa 2",
    "mdev-cbe1" => "mdev",
    "sdev-cbe1" => "sdev",
    "mtprod-cbeserver1.flatworld.com" => "prod 1",
    "mtprod-cbeserver2.flatworld.com" => "prod 2",
    "fwk-experiments" => "Scholar X",
    "fwk-scholar1" => "Scholar 1",
    "fwk-scholar2" => "Scholar 2"
  }

  def server_name(server_name)
    SERVER_MAP.fetch(server_name, server_name)
  end

  def repo_name(repo_name)
    REPO_MAP.fetch(repo_name, repo_name)
  end
end

