require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #show' do
    before { get :show, params: { question_id: question, id: answer } }

    it 'assigns the requested answer of question to @answer' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new, params: { question_id: question } }

    it 'assigns a new Answer of question to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new answer of question in the database' do
        expect do
          post :create, params: { question_id: question,
                                  answer:
                                  attributes_for(:answer,
                                                 question: question) },
               format: :js
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:answer,
                                                       question: question,
                                                       user: @user) },
             format: :js
        expect(response)
          .to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect do
          post :create, params: { question_id: question,
                                  answer: attributes_for(:invalid_answer) },
               format: :js
        end.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:invalid_answer) },
             format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before { question }
    before { answer }
    let!(:user_answer) { create(:answer, question: question, user: @user) }

    it 'deletes user answer' do
      expect do
        delete :destroy, params: { question_id: question,
                                   id: user_answer }
      end.to change(Answer, :count).by(-1)
    end

    it 'fail delete another\'s user answer' do
      expect { delete :destroy, params: { question_id: question, id: answer } }
        .to change(Answer, :count).by(0)
    end

    it 'redirect to question view' do
      delete :destroy, params: { question_id: question, id: answer }
      expect(response).to redirect_to question_path(question)
    end
  end
end
