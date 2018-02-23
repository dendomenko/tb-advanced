module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def add_vote(user_id, rate)
    return if self.user_id == user_id
    vote = votes.find_by(user_id: user_id)
    votes.create(user_id: user_id, rate: rate) && return unless vote
    vote.update(user_id: user_id, rate: rate) && return if vote.rate != rate.to_i
    vote.destroy
  end

  def rating
    votes.sum(:rate)
  end

end
