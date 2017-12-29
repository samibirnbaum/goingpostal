class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new  #a new post object taken from the model to be sent to the view
  end

  def create
    @post = Post.new            #creates new post object using info from form
    @post.title = params[:post][:title] #params is a method which accesses the parameters of a POST method, POST url parameters = 2d hash
    @post.body = params[:post][:body]
    @post.topic = Topic.find(params[:topic_id])

    if @post.save #AR method to save to the db was successful
      flash[:notice] = "Post was saved to topic #{@post.topic.name}." #on the flash hash sets key :notice to this string value - will display hash in view
      redirect_to(topic_post_path(@post.topic_id, Post.last.id)) #redirects to posts/show view - GET method
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new #GET call
    end
  end

  def edit
    id_param = params[:id]
    @post = Post.find(id_param)
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    
    if @post.save
      flash[:notice] = "Your post was successfully updated!"
      redirect_to(topic_post_path(@post.topic_id, Post.last.id))
    else
      flash.now[:alert] = "There was an error processing your update - Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id]) #first get row from db
    
    if @post.destroy #destory row in db
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to(topic_path(params[:topic_id]))
    else
      flash.now[:alert] = "There was an error deleting the post."
      render(topic_path(params[:topic_id]))
    end
  end
end
