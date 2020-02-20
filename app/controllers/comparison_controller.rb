class ComparisonController < ApplicationController
  def index
    @posts = Post.all
    @articles = Article.all
  end
end
