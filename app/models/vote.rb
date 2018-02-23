class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :rate, presence: true
  validates :rate, inclusion: { in: [1, -1] }
  validates :user_id, uniqueness: { scope: [:votable_type, :votable_id], message: 'You already have been voted!' }

  validate :not_author

  def not_author
    if votable.user == user
      errors.add(:author, "can't vote!")
    end
  end
end
