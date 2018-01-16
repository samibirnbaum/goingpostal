class PostsController < ApplicationController

  before_action :require_sign_in, except: :show #before all actions run this method (except show)
  before_action :authorise_user_member, except: [:show, :new, :create]
  before_action :authorise_user_moderator, except: [:show, :new, :create, :edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new  #a new post object taken from the model to be sent to the view
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save #AR method to save to the db was successful
      flash[:notice] = "Post was saved to topic #{@post.topic.name}." #on the flash hash sets key :notice to this string value - will display hash in view
      redirect_to(topic_post_path(@post.topic_id, @post.id)) #redirects to posts/show view - GET method
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    id_param = params[:id]
    @post = Post.find(id_param)
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    
    if @post.save
      flash[:notice] = "Your post was successfully updated!"
      redirect_to(topic_post_path(@post.topic_id, @post.id))
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

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end

    def authorise_user_member
      post = Post.find(params[:id]) #using post id in url request get the post

      if current_user.member? && current_user != post.user #member trying to do something to someone elses posts
        flash[:alert] = "you must be an admin to do that"
        redirect_to topic_post_path(post.topic_id, post.id)
      end
    end

    def authorise_user_moderator
      post = Post.find(params[:id])
      
      if current_user.moderator? && current_user != post.user
        flash[:alert] = "you must be an admin to do that"
        redirect_to topic_post_path(post.topic_id, post.id)
      end
    end
end
