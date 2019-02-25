class TestdatenMailer < ApplicationMailer
  default from: 'do-not-reply@yooyuu.de'
 
  def testdaten
    @org = params[:org]
    mail(to: 'dahmer@yooyuu.de, l.dahmer@yooyuu.de', subject: 'Testdaten angefordert')
  end
  
end