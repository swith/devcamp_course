class PagesController < ApplicationController
  def home
    @posts = Blog.all
    @skills = Skill.all
  end

  def about
    @skills = Skill.all
  end

  def contact
  end

  def gh_acc_news
    @repos = SocialTool.github_search('swith')
  end
end
