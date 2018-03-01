class AnswerForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_reader :question

  validates :body, presence: true

  delegate :question_id, :body,:user_id, to: :answer

  def initialize(user, question)
    @testuser = user
    @question = question
  end

  def answer
    @answer ||= @question.answers.build
  end

  def submit(params)
    answer.attributes = params.require(:answer_form).permit(:body)
    params[:file]&.each do |file|
      answer.attachments.build(file: file)
    end
    answer.user = @testuser
    if valid?
      answer.save!
      true
    else
      false
    end
  end
end
