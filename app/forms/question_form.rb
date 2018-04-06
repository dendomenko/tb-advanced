class QuestionForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  validates :body, :title, presence: true

  attr_accessor :tag_list

  delegate :title, :body, :user_id, to: :question

  def initialize(user)
    @user = user
  end

  def question
    @question ||= Question.new
  end

  def submit(params)
    question.attributes = params.require(:question_form).permit(:title, :body, :tag_list)
    params[:file]&.each do |file|
      question.attachments.build(file: file)
    end
    question.user = @user
    if question.valid?
      question.save!
      true
    else
      false
    end
  end
end
