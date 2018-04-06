class Answer < ApplicationRecord
  searchkick

  include Author
  include Votable

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :question, touch: true
  belongs_to :user

  validates :body, presence: true
  validates_uniqueness_of :best, if: :best, scope: :question_id

  scope :best_answer, -> { where(best: true) }
  scope :answers_without_best, -> { where(best: false) }

  after_create :answer_notification

  def make_best
    return nil if best?
    question.answers.update_all(best: false)
    update(best: true)
  end

  def question_author_id
    question.user_id
  end

  private

  def answer_notification
    question.subscriptions.each do |subscription|
      QuestionMailer.answer_notification(subscription.user, question).deliver_later
    end
  end
end
