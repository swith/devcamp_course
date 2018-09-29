module SocialTool
  def self.github_search(user)
    Github.repos.list(user: user).collect do |repo|
      "#{repo.full_name}: #{repo.clone_url}"
    end
  end
end
