class ComparisonController < ApplicationController
  def index
    @posts = Post.all.order(id: :asc)
    @articles = Article.all.order(id: :asc)
  end
end
