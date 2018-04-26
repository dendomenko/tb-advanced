require 'rails_helper'

RSpec.describe VideoGenre, type: :model do
  it { should belong_to(:genre) }
  it { should belong_to(:movie) }
end
