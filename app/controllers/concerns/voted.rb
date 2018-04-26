module Voted
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, only: %i[upvote downvote unvote]
    before_action :find_votable, only: %i[upvote downvote unvote]
  end

  def upvote
    authorize @votable, :not_author?
    @vote = @votable.add_vote(current_user.id, 1)
    save_vote
  end

  def downvote
    authorize @votable, :not_author?
    @vote = @votable.add_vote(current_user.id, -1)
    save_vote
  end

  def unvote
    @votable.remove_vote(current_user.id)
    respond_to do |format|
      format.json { render json: @votable.rating }
    end
  end

  private

  def save_vote
    respond_to do |format|
      if @vote.save
        format.json { render json: { rating: @votable.rating } }
      else
        format.json do
          render json: { errors: @vote.errors.messages },
                 status: 422
        end
      end
    end
  end

  def model_klass
    controller_name.classify.constantize
  end

  def find_votable
    @votable = model_klass.find(params[:id])
  end
end
