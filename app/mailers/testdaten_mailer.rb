class TestdatenMailer < ApplicationMailer
  default from: 'do-not-reply@yooyuu.de'
 
  def testdaten
    @org = params[:org]
    mail(to: 'dahmer@yooyuu.de, l.dahmer@yooyuu.de', 
         subject: 'Testdaten angefordert')
  end
  
  def fehlermeldung
    @betreff = params[:betreff]
    @attachment = params[:attachment]
    @nachricht = params[:nachricht]
    @organization = params[:organization]
    @user_name = params[:user_name]
    @op_system = params[:op_system]
    @email = params[:email]
    attachments[@attachment] = File.read(params[:attachment])
    mail(to: 'l.dahmer@yooyuu.de', 
         subject: 'Fehlermeldung')
  end
  
end