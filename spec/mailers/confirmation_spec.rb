require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  describe 'confirmation' do
    let(:email) { 'test@example.com' }
    let(:link) { Base64.encode64("#{email}:123456:twitter") }
    let(:mail) { described_class.send_confirmation(email, link).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Confirm your email')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['administrator@test.com'])
    end
  end
end
