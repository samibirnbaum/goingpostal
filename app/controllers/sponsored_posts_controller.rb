class SponsoredPostsController < ApplicationController
    def new
        @spost = SponsoredPost.new
        @topic = Topic.find(params[:topic_id])
    end

    def create
        @spost = SponsoredPost.new
        @spost.title = params[:sponsored_post][:title]
        @spost.body = params[:sponsored_post][:body]
        @spost.price = params[:sponsored_post][:price]
        @spost.topic_id = params[:topic_id]

        if @spost.save
            flash[:notice] = "Your new sponsored post has been saved"
            redirect_to(topic_path(params[:topic_id]))
        else
            flash.now[:alert] = "Error creating sponsored post. Please try again"
            render :new
        end
    end

    def show
        @spost = SponsoredPost.find(params[:id])
    end

    def destroy
        @spost = SponsoredPost.find(params[:id])

        if @spost.destroy
            flash[:notice] = "\"#{@spost.title}\" was successfully deleted"
            redirect_to(topic_path(params[:topic_id]))
        else
            flash.now[:alert] = "Error. Please try again"
            render :show
        end
    end

    def edit
        @topic = Topic.find(params[:topic_id])
        @spost = SponsoredPost.find(params[:id])
    end

    def update
        @spost = SponsoredPost.find(params[:id])
        @spost.title = params[:sponsored_post][:title]
        @spost.body = params[:sponsored_post][:body]
        @spost.price = params[:sponsored_post][:price]
        @spost.topic_id = params[:topic_id]

        if @spost.save
            flash[:notice] = "your sponsored post was successfully updated!"
            redirect_to(topic_path(params[:topic_id]))
        else
            flash.now[:alert] = "Error. Please try again"
            render :edit
        end
    end
end
