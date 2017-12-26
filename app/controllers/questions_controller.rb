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
    @question = Question.find(params[:id])
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
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = "Your question was successfully updated"
      redirect_to(question_path(params[:id]))
    else
      flash.now[:alert] = "There was a problem updating your question. Please try again"
      render(edit_question_path(params[:id]))
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      flash[:notice] = "\"#{@question.title}\" was successfully deleted" 
      redirect_to(questions_path)
    else
      flash.now[:alert] = "There was an error deleting your question. Please try again"
      render :show
    end
  end
end
