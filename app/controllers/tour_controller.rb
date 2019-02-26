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
    @tour_records = @tour_table.records
    @step_records = @step_table.records
    
    Tour.all.each do |tour|
      record = @tour_table.select(formula: "tour_id = #{tour.id}").first
      tour.name = record[:name]
      tour.description = record[:description]
      tour.image_url = record[:image_url]
      tour.save!
    end
    
    Step.all.each do |step|
      record = @step_table.select(formula: "step_id = #{step.id}").first
      step.step = record[:step]
      step.tour_id = record[:tour_id].first
      step.head = record[:head]
      step.body = record[:body]
      step.type = record[:type]
      step.video_url = record[:video_url]
      step.est_time = record[:est_time]
      step.image_url = record[:image_url]
      step.save!
    end
      
    @stepcount = @step_table.all(:sort => ["step_id", :desc]).first[:step_id]
    @tourcount = @tour_table.all(:sort => ["tour_id", :desc]).first[:tour_id]
    
    if Step.last.id < @stepcount
      @step_table.select(formula: "step_id > #{Step.last.id}").each do |step_table|
        Step.create(step: record[:step], tour_id: record[:tour_id].first, head: record[:head], body: record[:body], type: record[:type], video_url: record[:video_url], est_time: record[:est_time], image_url: record[:image_url])
      end
    end  
    
    if Tour.last.id < @tourcount
      @tour_table.select(formula: "step_id > #{Tour.last.id}").each do |step_table|
        Tour.create(step: record[:step], tour_id: record[:tour_id].first, head: record[:head], body: record[:body], type: record[:type], video_url: record[:video_url], est_time: record[:est_time], image_url: record[:image_url])
      end
    end 
    
  end
  
  private
  
end