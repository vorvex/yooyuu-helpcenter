class WelcomeController < ApplicationController
  layout 'welcome'
  
  def index
    @tour = Tour.all.limit(4)
    @faqs = Question.where('sort = ?', 'faq').all.limit(8)
    @tutorials = Question.where('sort = ?', 'tutorial').all.limit(8)
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
  
  def quicksearch 
    @search = params[:q].downcase
    @questions = Question.where('lower(head) LIKE ? OR lower(body) LIKE ?', "%#{@search}%", "%#{@search}%").limit(5)
    
    respond_to do |format|
      format.js { render partial: 'welcome/quicksearch' }
    end
  end
  
end
