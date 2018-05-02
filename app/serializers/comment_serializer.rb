class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :user, :created_at

  has_one :user
end
