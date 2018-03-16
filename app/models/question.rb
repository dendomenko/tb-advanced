# frozen_string_literal: true

class Question < ApplicationRecord
  include Author
  include Votable

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user

  validates :body, :title, presence: true

  after_create :subscribe_user
  after_update :question_update_notification

  private

  def subscribe_user
    subscriptions.create(user_id: user_id)
  end

  def question_update_notification
    subscriptions.each do |subscription|
      QuestionMailer.update_notification(subscription.user, self).deliver_later
    end
  end
end
