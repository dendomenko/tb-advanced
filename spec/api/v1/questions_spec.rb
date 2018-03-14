require 'rails_helper'

RSpec.describe 'Questions API' do
  describe 'GET /index' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/questions', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/questions', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:user) }

      it 'returns 200 status code' do
        get '/api/v1/questions', params: { format: :json, access_token: access_token.token }
        expert(response).to be_success
      end
    end
  end
end