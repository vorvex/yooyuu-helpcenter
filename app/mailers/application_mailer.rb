class ApplicationMailer < ActionMailer::Base
  default from: 'do-not-reply@yooyuu.de'
  layout 'mailer'
  
  class TestdatenMailer < ApplicationMailer
  end
  
end