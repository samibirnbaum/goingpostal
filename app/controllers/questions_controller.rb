class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
  end

  
  
  
  
  def create
    @question = Question.new
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = 0

    if @question.save
      flash[:notice] = "Success! Your new question was created"
      redirect_to(question_path(Question.last.id))
    else
      flash.now[:alert] = "There was an error creating your question - Please try again."
      render :new
    end
  end

  def update
  end

  def delete
  end
end
