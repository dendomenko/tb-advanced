class Answer < ApplicationRecord
  include Author

  belongs_to :question
  belongs_to :user

  validates :answer, presence: true
end
