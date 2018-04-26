module Api
  module V1
    class AnswersController < Api::V1::ApiController
      before_action :set_question
      def index
        @answers = @question.answers
        respond_with @answers
      end

      def show
        @answer = @question.answers.find_by_id(params[:id])
        respond_with @answer
      end

      def create
        @answer = @question.answers.create(answer_params.merge(user_id: current_resource_owner.id))
        respond_with(@question, @answer)
      end

      private

      def answer_params
        params.require(:answer).permit(:body)
      end

      def set_question
        @question = Question.find(params[:question_id])
      end
    end
  end
end
