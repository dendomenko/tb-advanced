class Movie < ApplicationRecord
  has_many :video_genres
  has_many :genres, through: :video_genres

  has_many :video_positions
  has_many :people, through: :video_positions
  has_many :positions, through: :video_positions

  has_many :movie_ratings, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :description, :year, presence: true
end