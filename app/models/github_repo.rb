class GithubRepo < ApplicationRecord
  def url
    @url = self.html_url
  end
end
