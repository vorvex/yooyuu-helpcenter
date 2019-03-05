class WelcomeController < ApplicationController
  layout 'welcome'
  
  def index
    @tour = Tour.all.limit(4)
    @questions = Question.all.limit(8)
  end
  
  def search
    search = params[:q]
    if search != ""
      @tour = Array.new()
      Tour.where('name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%").each do |tour|
        @tour << tour
      end
      Step.where('head LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%").each do |step|
        @tour << Tour.find(step.tour_id)
      end
      @tour = @tour.uniq
      @questions = Question.where('head LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%")
    else
      @tour = Tour.none
      @questions = Question.none
    end
  end
  
  
end
