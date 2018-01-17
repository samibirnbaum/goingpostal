class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorise_user, only: [:destroy]
    
    def create
        @comment = Comment.new
        @comment.body = params[:comment][:body]
        @comment.post_id = params[:post_id]
        @comment.user = current_user 

        if @comment.save
            flash[:notice] = "your comment has been submitted"
            redirect_to(topic_post_path(@comment.post.topic.id, @comment.post_id))
        else
            flash[:alert] = "Error: #{@comment.errors.full_messages[0] if @comment.invalid?}"
            redirect_to(topic_post_path(@comment.post.topic.id, @comment.post_id))
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])

        if @comment.delete
            flash[:notice] = "Comment was deleted"
            redirect_to(topic_post_path(@post.topic.id, @post.id))
        else
            flash[:alert] = "There was error deleting your comment. Please try again"
            redirect_to(topic_post_path(@post.topic.id, @post.id))
        end
    end


    private
        def authorise_user
            @comment = Comment.find(params[:id])
            
            unless current_user.admin? || current_user == @comment.user 
                flash[:alert] = "Sorry you need to be an admin to do that"
                redirect_to(topic_post_path(@comment.post.topic.id, @comment.post_id))    
            end
        end
end
