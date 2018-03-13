class ApplicationMailer < ActionMailer::Base
  default from: 'administrator@test.com'
  layout 'mailer'
end
