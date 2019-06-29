class CreateGithubRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :github_repos do |t|
      t.string :name
      t.string :html_url
    end
  end
end
