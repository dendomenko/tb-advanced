# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :rate, presence: true
  validates :rate, inclusion: { in: [1, -1] }
  validates :user_id, uniqueness: { scope: %i[votable_type votable_id], message: 'You already have been voted!' }

  validate :not_author

  def not_author
    errors.add(:author, "Author can't vote!") if votable.user == user
  end
end
