class FavoritesController < ApplicationController
    
    before_action :require_sign_in

    def create
        post = Post.find(params[:post_id])
        user = current_user
        favorite = Favorite.new(user_id: user.id, post_id: post.id)

        if favorite.save
            flash[:notice] = "Post Favorited!"
        else
            flash[:alert] = "Attempt to favorite post failed"
        end

        redirect_to(topic_post_path(post.topic.id, post.id))
    end

    def destroy
        post = Post.find(params[:post_id])
        favorite = Favorite.find(params[:id])

        if favorite.delete
            flash[:notice] = "Post Un-Favorited!"
        else
            flash[:alert] = "Attempt to un-favorite post failed"
        end

        redirect_to(topic_post_path(post.topic.id, post.id))
    end
end
