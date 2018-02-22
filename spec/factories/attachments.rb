FactoryBot.define do
  factory :attachment do
    file do
      Rack::Test::UploadedFile.new(Rails.root.join('spec', 'spec_helper.rb'))
    end
  end
end
