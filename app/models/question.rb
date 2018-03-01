# frozen_string_literal: true

class Question < ApplicationRecord
  include Author
  include Votable

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user


  # accepts_nested_attributes_for :attachments, reject_if: :all_blank,
  #                                             allow_destroy: true
end
