class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :text, presence: true

  default_scope { order(created_at: :asc) }
end
