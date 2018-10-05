class TopicsController < ApplicationController
  before_action :set_sidebar_topics
  layout 'blog'

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    if logged_in?(:site_admin)
      @blogs = @topic.blogs
    else
      @blogs = @topic.blogs.published
    end
    @blogs = @blogs.recent.page(params[:page]).per(5)
  end

  private

  def set_sidebar_topics
    @side_bar_topics = Topic.with_blogs
  end
end
