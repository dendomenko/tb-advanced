require 'rails_helper'

RSpec.describe Position, type: :model do
  it { should validate_presence_of :title }
  it { should have_many(:movies) }
  it { should have_many(:people) }
end
