class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_id, uniqueness: { scope: :question_id }

  def self.send_daily_newsletter
    User.all.each do |user|
      DailyMailer.daily_newsletter(user.email).deliver_later
    end
  end
end
