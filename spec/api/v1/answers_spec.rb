require 'rails_helper'

RSpec.describe 'Questions API' do
  describe 'GET /index' do
    let!(:question) { create(:question) }
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers", params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:answers) { create_list(:answer, 2, question: question) }
      let!(:answer) { answers.first }
      let!(:comment) { create(:comment, commentable_type: 'Answer', commentable_id: answer.id) }
      let!(:attachment) { create(:attachment, attachable_type: 'Answer', attachable_id: answer.id) }

      before { get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(2)
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'comments' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/comments")
        end

        %w(id text user_id).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("0/comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("0/attachments")
        end

        it "attachment object contains url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("0/attachments/0/url")
        end
      end
    end
  end

  describe 'GET /show' do
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, id: 1, question: question) }
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers/1", params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}/answers/1", params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:comment) { create(:comment, commentable_type: 'Answer', commentable_id: answer.id) }
      let!(:attachment) { create(:attachment, attachable_type: 'Answer', attachable_id: answer.id) }

      before { get "/api/v1/questions/#{question.id}/answers/1", params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      %w(id body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end

      context 'comments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(1).at_path("comments")
        end

        %w(id text user_id).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(1).at_path("attachments")
        end

        it "attachment answer contains url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("attachments/0/url")
        end
      end
    end
  end

  describe 'POST /create' do
    let!(:question) { create(:question) }
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        post "/api/v1/questions/#{question.id}/answers", params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        post "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:answer_params) { attributes_for(:answer, question: question) }

      before {  post "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token, answer: answer_params, question_id: question.id} }

      it 'returns 201 status code' do
        expect(response).to have_http_status :created
      end

      %w[body].each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer_params[(attr.to_sym)].to_json).at_path("#{attr}")
        end
      end

      context 'comments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(0).at_path("comments")
        end
      end

      context 'attachments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(0).at_path("attachments")
        end
      end
    end
  end
end