require 'rails_helper'

RSpec.describe Movie, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :year }
  it { should have_many(:genres) }
  it { should have_many(:people) }
  it { should have_many(:positions) }
  it { should have_many(:video_genres) }
  it { should have_many(:video_positions) }
end
