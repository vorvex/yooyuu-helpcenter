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
    @search = params[:q].downcase
    if @search != ""
      @questions = Question.where('lower(head) LIKE ? OR lower(body) LIKE ?', "%#{@search}%", "%#{@search}%").limit(5)
    else
      @questions = Question.none
    end
    respond_to do |format|
      format.js { render partial: 'tour/quicksearch' }
    end
  end
  
  
  def step
    @tour = Tour.find_by_path(params[:path])
    @step = @tour.steps.find_by_step(params[:step])
    @images = @step.image_url.split(',')
    @time_done = 0
    @tour.steps.where('step < ?', @step.step).each do |step|
      @time_done += step.est_time
    end
      
    @title = "YooYuu | " + @step.head
    @image = "/a/willkommen.jpg"
    @description = @step.body
    
  end
    
  def start_tour
    @tour = Tour.find_by_path(params[:path])
    @step = @tour.steps.find_by_step(0)
    @images = @step.image_url.split(',')
    
    @title = "YooYuu | " + @tour.name
    @image = "@images.first"
    @description = @tour.description
  end
  
  def fehlerbehebung
    @title = "YooYuu | Fehlerbehebung"
    @image = "/a/willkommen.jpg"
    @description = "Sie haben einen Fehler oder ein Problem in der App oder der Web-App gefunden? Schicken Sie uns bitte eine Anfrage über das Formular und befolgen Sie die nachfolgenden Schritte." 
  end
    
  def fehlerbehebung_form
    @title = "YooYuu | Fehlerbehebung"
  end  
    
  def create_fehlermeldung
    TestdatenMailer.with( betreff: params[:betreff],
                          attachment: params[:attachment],
                          nachricht: params[:nachricht],
                          organization: params[:organization],
                          user_name: params[:user_name],
                          op_system: params[:op_system],
                          email: params[:email]
                  ).fehlermeldung.deliver_now
    
    redirect_to "/"
    
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
    
    if Tour.last.id < @tourcount
      @tour_table.select(formula: "step_id > #{Tour.last.id}").each do |record|
        Tour.create(name: record[:name], description: record[:description], image_url: record[:image].first[:url], path: record[:path], final_path: record[:final_path])
      end
    end 
    
    if Step.last.id < @stepcount
      @step_table.select(formula: "step_id > #{Step.last.id}").each do |record|
        Step.create(step: record[:step], tour_id: record[:tour_id].first, head: record[:head], body: record[:body], sort: record[:type], video_url: record[:video_url], est_time: record[:est_time], secondary_button_link: record[:button_link], secondary_button_text: record[:button_text])
      end
    end  
    
    if Question.last.nil? 
      lastquestion = 0
    else
      lastquestion = Question.last.id
    end
      
    
    if lastquestion < @questioncount
      @question_table.select(formula: "question_id > #{lastquestion}").each do |record|
        Question.create(head: record[:head], body: record[:body], sort: record[:type], video_url: record[:video_url], image_url: "", thumbnail_url: "")
      end
    end
    
    Tour.all.each do |tour|
      record = @tour_table.select(formula: "tour_id = #{tour.id}").first
      if record != nil && record[:status] == "Fertig"
        tour.name = record[:name]
        tour.description = record[:description]
        tour.path = record[:path]
        tour.final_path = record[:final_path]
        if record[:image].first.empty?
          tour.image_url = ""
        else
          tour.image_url = record[:image].first[:thumbnails][:large][:url]
        end
        tour.save!
      end
    end
    
    Step.all.each do |step|
      record = @step_table.select(formula: "step_id = #{step.id}").first
      if record != nil && record[:status] == "Fertig"
        step.step = record[:step]
        step.tour_id = record[:tour_id].first
        step.head = record[:head]
        step.body = record[:body]
        step.sort = record[:type]
        step.secondary_button_link = record[:button_link]
        step.secondary_button_text = record[:button_text]
        step.video_url = record[:video_url]
        step.est_time = record[:est_time]
        if record[:image].first.empty?
          step.image_url = ""
        else
          images = Array.new
          record[:image].each do |image|
            images.append(image[:url])
          end
          delim = ','
          step.image_url = images.join(delim)
        end
        step.save!
      end
    end
    
    Question.all.each do |question|
      record = @question_table.select(formula: "question_id = #{question.id}").first
      if record != nil && record[:status] == "Fertig"
        question.head = record[:head]
        question.body = record[:body]
        question.sort = record[:type]
        question.video_url = record[:video_url]
        if record[:image].first.empty?
          question.image_url = ""
          question.thumbnail_url = record[:thumbnail].first[:url] unless record[:thumbnail].first.empty?
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