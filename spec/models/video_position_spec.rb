require 'rails_helper'

RSpec.describe VideoPosition, type: :model do
  it { should belong_to(:movie) }
  it { should belong_to(:position) }
  it { should belong_to(:person) }
end
