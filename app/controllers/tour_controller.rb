class TourController < ApplicationController
  
  def willkommen_organizator
    @tour = Tour.first
  end
  
  def willkommen_employee
    
  end
  
  def testdaten
    TestdatenMailer.with(org: params[:org]).testdaten.deliver_now
  end
  
  def overview
    
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def delete
    
  end
  
  private
  
end