module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def add_vote(user_id, rate)
    votes.build(user_id: user_id, rate: rate)
  end

  def remove_vote(user_id)
    vote = votes.find_by(user_id: user_id)
    vote.destroy
  end

  def rating
    votes.sum(:rate)
  end

  def voted?(user_id)
    votes.find_by(user_id: user_id) ? true : false
  end
end
