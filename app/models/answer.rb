class Answer < ApplicationRecord
  include Author

  belongs_to :question
  belongs_to :user

  validates :answer, presence: true
  validates_uniqueness_of :best, if: :best?, scope: :question_id

  def make_best
    question.answers.update_all(best: false)
    update(best: true)
  end
end
