require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  it 'perform daily digest newsletter' do
    expect(Subscription).to receive(:send_daily_newsletter)
    DailyDigestJob.perform_now
  end
end