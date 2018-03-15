require 'rails_helper'

RSpec.describe 'Profile API' do
  describe 'GET /me' do
    it_behaves_like 'API Authenticable' do
      let(:empty_request) { get '/api/v1/profiles/me', params: { format: :json } }
      let(:wrong_token_request) { get '/api/v1/profiles/me', params: { format: :json, access_token: '1234' } }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      %w(id email).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end

  describe 'GET /profiles' do
    it_behaves_like 'API Authenticable' do
      let(:empty_request) { get '/api/v1/profiles', params: { format: :json } }
      let(:wrong_token_request) { get '/api/v1/profiles', params: { format: :json, access_token: '1234' } }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:user) { create(:user) }

      before { get '/api/v1/profiles', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      %w(id email).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(user.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end
end
