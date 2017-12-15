class PostsController < ApplicationController
  def index
    @posts = Post.all #returns array from db of all post objects
  end

  def show
  end

  def new
  end

  def edit
  end
end
