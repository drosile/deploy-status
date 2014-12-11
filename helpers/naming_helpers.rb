module NamingHelpers
  REPO_MAP = {
    "admin-web" => "id-web",
    "comp-web" => "cbe-web"
  }

  SERVER_MAP = {
    "bu-cbeserver1.flatworldknowledge.com" => "brandman",
    "bustage-cbeserver1.flatworldknowledge.com" => "brandman stage",
    "demo-cbeserver1.flatworldknowledge.com" => "demo",
    "dev-cbeserver1.flatworldknowledge.com" => "dev",
    "lt-cbeserver1.flatworldknowledge.com" => "laureate",
    "ltstage-cbeserver1.flatworldknowledge.com" => "laureate stage",
    "qa-cbeserver1.flatworldknowledge.com" => "qa",
    "mqa-cbeserver1.flatworldknowledge.com" => "mqa",
    "template-cbeserver1.flatworldknowledge.com" => "template"
  }

  def server_name(server_name)
    SERVER_MAP.fetch(server_name, server_name)
  end

  def repo_name(repo_name)
    REPO_MAP.fetch(repo_name, repo_name)
  end
end

