class Comment < ApplicationRecord
  searchkick

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true

  validates :text, presence: true

  default_scope { order(created_at: :asc) }
end
