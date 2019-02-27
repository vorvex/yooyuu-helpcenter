class TourController < ApplicationController
  
  def willkommen_organizator
    @tour = Tour.first
    
    @title = "YooYuu | Erste Schritte Organisator"
    @image = "/a/willkommen.jpg"
    @description = @tour.description
  end
  
  def willkommen_employee
    @title = "YooYuu | Erste Schritte Angestellte"
    @image = "/a/willkommen-angestellter.jpg"
    @description = ""
  end
  
  def testdaten
    TestdatenMailer.with(org: params[:org]).testdaten.deliver_now
  end
  
  def searchajax
    search = params[:q]
    if search != ""
      @search = Question.where('head LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%").limit(5);
    else
      @search = Question.none
    end
    respond_to do |format|
      format.js { render partial: 'tour/search' }
    end
  end
  
  
  def step
    @tour = Tour.find_by_name(params[:name])
    @step = @tour.steps.find_by_step(params[:step])
    @time_done = 0
    @tour.steps.where('step < ?', @step.step).each do |step|
      @time_done += step.est_time
    end
      
    @title = "YooYuu | " + @step.head
    @image = "/a/willkommen.jpg"
    @description = @step.body
    
  end
  
  def update
    @client = Airtable::Client.new("keykRKN6ZrrNdvLzT")
    @tour_table = @client.table("appihv8aKj9Q7Qm7B", "tour")
    @step_table = @client.table("appihv8aKj9Q7Qm7B", "step")
    @question_table = @client.table("appihv8aKj9Q7Qm7B", "questions")
    @tour_records = @tour_table.records
    @step_records = @step_table.records
    @question_records = @question_table.records
    
    @stepcount = @step_table.all(:sort => ["step_id", :desc]).first[:step_id]
    @tourcount = @tour_table.all(:sort => ["tour_id", :desc]).first[:tour_id]
    @questioncount = @question_table.all(:sort => ["question_id", :desc]).first[:question_id]
    
    if Step.last.id < @stepcount
      @step_table.select(formula: "step_id > #{Step.last.id}").each do |record|
        Step.create(step: record[:step], tour_id: record[:tour_id].first, head: record[:head], body: record[:body], type: record[:type], video_url: record[:video_url], est_time: record[:est_time], image_url: record[:image].first[:url])
      end
    end  
    
    if Tour.last.id < @tourcount
      @tour_table.select(formula: "step_id > #{Tour.last.id}").each do |record|
        Tour.create(name: record[:name], description: record[:description], image_url: record[:image].first[:url])
      end
    end 
    
    if Question.last.nil? 
      lastquestion = 0
    else
      lastquestion = Question.last.id
    end
      
    
    if lastquestion < @questioncount
      @question_table.select(formula: "question_id > #{lastquestion}").each do |record|
        Question.create(head: record[:head], body: record[:body], type: record[:type], video_url: record[:video_url], image_url: "", thumbnail_url: "")
      end
    end
    
    Tour.all.each do |tour|
      record = @tour_table.select(formula: "tour_id = #{tour.id}").first
      if record != nil
        tour.name = record[:name]
        tour.description = record[:description]
        if record[:image].first.empty?
          tour.image_url = ""
        else
          tour.image_url = record[:image].first[:url]
        end
        tour.save!
      end
    end
    
    Step.all.each do |step|
      record = @step_table.select(formula: "step_id = #{step.id}").first
      if record != nil
        step.step = record[:step]
        step.tour_id = record[:tour_id].first
        step.head = record[:head]
        step.body = record[:body]
        step.type = record[:type]
        step.video_url = record[:video_url]
        step.est_time = record[:est_time]
        if record[:image].first.empty?
          step.image_url = ""
        else
          step.image_url = record[:image].first[:url]
        end
        step.save!
      end
    end
    
    Question.all.each do |question|
      record = @question_table.select(formula: "question_id = #{question.id}").first
      if record != nil
        question.head = record[:head]
        question.body = record[:body]
        question.type = record[:type]
        question.video_url = record[:video_url]
        if record[:image].first.empty?
          question.image_url = ""
          question.thumbnail_url = ""
        else
          question.image_url = record[:image].first[:url]
          question.thumbnail_url = record[:image].first[:thumbnails][:large][:url]
        end
        question.save!
      end
    end 
    
  end
  
  private
  
end