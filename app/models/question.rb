# frozen_string_literal: true

class Question < ApplicationRecord
  include Author
  include Votable

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user

  validates :body, :title, presence: true
end
