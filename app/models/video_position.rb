class VideoPosition < ApplicationRecord
  belongs_to :movie
  belongs_to :person
  belongs_to :position
end
