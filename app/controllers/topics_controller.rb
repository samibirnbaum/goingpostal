class TopicsController < ApplicationController
    
    before_action :require_sign_in, except: [:index, :show]
    before_action :authorise_user, except: [:index, :show]
    
    def index
        @topics = Topic.all
    end

    def show
        @topic = Topic.find(params[:id])
    end

    def new
        @topic = Topic.new
    end

    def create
        @topic = Topic.new(topic_params)

        if @topic.save
            flash[:notice] = "Your new topic was successfully created"
            redirect_to(topic_path(Topic.last.id))
        else
            flash.now[:alert] = "There was an error creating your new topic. Please try again."
            render(:new)
        end
    end

    def edit
        @topic = Topic.find(params[:id])
    end

    def update
        @topic = Topic.find(params[:id])        
        @topic.assign_attributes(topic_params)

        if @topic.save
            flash[:notice] = "Your updated topic was successfully saved"
            redirect_to(topic_path(@topic.id))
        else
            flash.now[:alert] = "There was an error creating your new topic. Please try again."
            render(:edit)
        end
    end

    def destroy
        @topic = Topic.find(params[:id])

        if @topic.destroy
            flash[:notice] = "\"#{@topic.name}\" was successfully deleted"
            redirect_to(topics_path) #this method calls a controller action so could have written (:index) to call the controller action
        else
            flash.now[:alert] = "There was an error deleting your topic. Please try again."
            redirect_to(topic_path(@topic.id))
        end
    end

    private
        def topic_params
            params.require(:topic).permit(:name, :description, :public)
        end

        def authorise_user
            unless current_user.admin?
                flash[:alert] = "you must be an admin to do that"
                redirect_to(topics_path)
            end
        end
end
