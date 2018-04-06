class Position < ApplicationRecord
  has_many :video_positions
  has_many :movies, through: :video_positions
  has_many :people, through: :video_positions

  validates :title, presence: true
end
