class Genre < ApplicationRecord
  has_many :video_genres
  has_many :movies, through: :video_genres

  validates :title, presence: true
end
