module Votable
  extend ActiveSupport::Concern

  def add_vote(data_id, user_id, rate)
    vote = votes.find_by(likeble_type: self.class.to_s, likeble_id: data_id, user_id: user_id)
    vote.destroy if vote
    votes.create!(user_id: user_id, rate: rate)
  end

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end
end
