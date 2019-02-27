class QuestionController < ApplicationController
  
  def show
    @question = Question.find_by_head(params[:head])
  end
  
end