class QuestionPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    true if user.present? && user == question.user
  end

  def destroy?
    true if user.present? && user == question.user
  end

  private

  def question
    record
  end
end
