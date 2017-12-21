class PostsController < ApplicationController
  def index
    @posts = Post.all #returns array from db of all post objects
  end

  def show
    #recieves post id, assign that post to @post var
    post_id = params[:id] #id obtained from the params hash in the url 
    @post = Post.find(post_id)
  end

  def new
    @post = Post.new  #a new post object taken from the model to be sent to the view
  end

  def create
    @post = Post.new            #creates new post object using info from form
    @post.title = params[:post][:title] #params is a method which accesses the parameters of a POST method, POST url parameters = 2d hash
    @post.body = params[:post][:body]

    if @post.save #AR method to save to the db was successful
      flash[:notice] = "Post was saved." #on the flash hash sets key :notice to this string value - will display hash in view
      redirect_to(post_path(Post.last.id)) #redirects to posts/show view - GET method
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new #GET call
    end
  end

  def edit
  end
end
