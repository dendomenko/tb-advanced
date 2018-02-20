module Author
  extend ActiveSupport::Concern

  def author?(c_user)
    user_id == c_user.id
  end
end
