class GithubRepo < ApplicationRecord
  def url
    self.html_url
  end
end
