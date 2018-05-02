class User < ApplicationRecord
  searchkick

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook twitter]

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization
    email = auth.info[:email]
    user = User.create_or_find_by_email(email)
    user.authorizations.create(provider: auth.provider, uid: auth.uid)
    user
  end

  def self.create_or_find_by_email(email)
    user = User.where(email: email).first
    unless user
      password = Devise.friendly_token(20)
      user = User.create!(email: email, password: password, password_confirmation: password)
    end
    user
  end
end
