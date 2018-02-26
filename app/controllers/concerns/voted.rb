module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_votable, only: [:vote, :unvote]
  end

  def vote
    @vote = @votable.add_vote(current_user.id, params[:rate])
    respond_to do |format|
      if @vote.save
        format.json { render json: {id: @votable.id, rating: @votable.rating } }
      else
        format.json do
          render json: { id: @votable.id, errors: @vote.errors.messages.values },
                 status: 422
        end
      end
    end
  end

  def unvote
    @votable.remove_vote(current_user.id)
    respond_to do |format|
      format.json { render json: @votable.rating }
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def find_votable
    @votable = model_klass.find(params[:id])
  end
end
