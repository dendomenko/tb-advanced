module Author
  extend ActiveSupport::Concern

  def author?(c_user)
    user == c_user
  end
end
