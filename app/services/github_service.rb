class GithubService
  attr_accessor :access_token

  def initialize(access_hash=nil)
    @access_token = access_hash["access_token"] if access_hash
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret,code: code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    @access_token = access_hash["access_token"]
  end

  def get_username
    response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    body = JSON.parse(response.body)
    body["login"]
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    repos_array = JSON.parse(response.body)
    repos_array.map{|r| GithubRepo.new(r)}
  end

  def create_repo(title)
    response = Faraday.post "https://api.github.com/user/repos", {name: title}.to_json, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
  end
end
