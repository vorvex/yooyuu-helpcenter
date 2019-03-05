class WelcomeController < ApplicationController
  layout 'welcome'
  
  def index
    @tour = Tour.all.limit(4)
    @questions = Question.all.limit(8)
  end
  
  def search
    search = params[:q].downcase
      @tour = Array.new()
      Tour.where('lower(name) LIKE ? OR lower(description) LIKE ?', "%#{search}%", "%#{search}%").each do |tour|
        @tour << tour
      end
      Step.where('lower(head) LIKE ? OR lower(body) LIKE ?', "%#{search}%", "%#{search}%").each do |step|
        @tour << Tour.find(step.tour_id)
      end
      @tour = @tour.uniq
      @questions = Question.where('lower(head) LIKE ? OR lower(body) LIKE ?', "%#{search}%", "%#{search}%")
  end
  
  
end
