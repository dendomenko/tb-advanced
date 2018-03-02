class Answer < ApplicationRecord
  include Author
  include Votable

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  validates_uniqueness_of :best, if: :best, scope: :question_id

  scope :best_answer, -> { where(best: true).limit(1) }
  scope :answers_without_best, -> { where(best: false) }

  def make_best
    return nil if best?
    question.answers.update_all(best: false)
    update(best: true)
  end

  def question_author_id
    question.user_id
  end
end
