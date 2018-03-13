class Authorization < ApplicationRecord
  belongs_to :user, optional: true
end
