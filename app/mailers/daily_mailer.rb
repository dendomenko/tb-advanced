class DailyMailer < ApplicationMailer
  def daily_newsletter(email)
    @email = email
    @questions = Question.where("created_at >= ?", Time.zone.yesterday.beginning_of_day)
    mail(to: email, subject: 'Daily Newsletter')
  end
end
