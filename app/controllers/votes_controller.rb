class VotesController < ApplicationController

    before_action :require_sign_in

    def up_vote
        update_vote(1)
        redirect_back(fallback_location: :root)
    end

    def down_vote
        update_vote(-1)
        redirect_back(fallback_location: :root)
    end


    private
        def update_vote(value)
            @post = Post.find(params[:post_id])
            @vote = @post.votes.where(user_id: current_user.id).first #find that vote object with that post and user id
    
            if @vote
                @vote.update_attribute(:value, value) #no matter how many times you vote, it will find YOUR vote and just change its attr to 1
            else
                Vote.create!(value: value, post: @post, user: current_user)
            end 
        end
end
