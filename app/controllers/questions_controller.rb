class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
  end

  def edit
  end

  
  
  
  
  def create
  end

  def update
  end

  def delete
  end
end
