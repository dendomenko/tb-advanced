class Person < ApplicationRecord
  has_many :video_positions
  has_many :movies, through: :video_positions
  has_many :positions, through: :video_positions

  validates :first_name, :last_name, :country, :birthday, presence: true
end
