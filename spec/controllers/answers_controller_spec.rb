require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new answer of question in the database' do
        expect do
          post :create, params: { question_id: question,
                                  answer_form:
                                  attributes_for(:answer,
                                                 question: question) },
                        format: :js
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question,
                                answer_form: attributes_for(:answer,
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
                                  answer_form: attributes_for(:invalid_answer) },
                        format: :js
        end.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question,
                                answer_form: attributes_for(:invalid_answer) },
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
                                   id: user_answer },
                         format: :js
      end.to change(Answer, :count).by(-1)
    end

    it 'fail delete another\'s user answer' do
      expect { delete :destroy, params: { question_id: question, id: answer } }
        .to change(Answer, :count).by(0)
    end

    it 'redirect to question view' do
      delete :destroy, params: { question_id: question, id: answer }
      expect(response).to redirect_to root_path
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:answer) { create(:answer, question: question, user: @user) }

    it 'assings the requested answer to @answer' do
      patch :update, params: { id: answer, question_id: question,
                               answer: attributes_for(:answer) }, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns th question' do
      patch :update, params: { id: answer, question_id: question,
                               answer: attributes_for(:answer) }, format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, question_id: question,
                               answer: { body: 'new body' } }, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: { id: answer, question_id: question,
                               answer: attributes_for(:answer) }, format: :js
      expect(response).to render_template :update
    end
  end

  describe 'PATCH #best' do
    sign_in_user

    let(:author_question) { create(:question, user: @user) }
    let(:answer) { create(:answer, question: author_question) }

    it 'assings the requested answer to @answer' do
      patch :best, params: { id: answer, question_id: author_question,
                             answer: { best: true } }, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns the question' do
      patch :best, params: { id: answer, question_id: author_question,
                             answer: { best: true } }, format: :js
      expect(assigns(:question)).to eq author_question
    end

    it 'changes answer best attribute' do
      patch :best, params: { id: answer, question_id: author_question,
                             answer: { best: true } }, format: :js
      answer.reload
      expect(answer.best).to eq true
    end

    it 'render best template' do
      patch :best, params: { id: answer, question_id: author_question,
                             answer: attributes_for(:answer) }, format: :js
      expect(response).to render_template :best
    end
  end

  it_behaves_like 'Votable' do
    let!(:question) { create(:question) }
    let(:options) { {question_id: question.id} }
    let(:votable) { create(:answer, question: question) }
    let(:my_votable) { create(:answer, question: question, user: @user) }

    let(:another_user) { create(:user) }
    let(:voted_votable) { create(:answer, question: question, user: another_user) }
    let(:delete_request) { delete :unvote, params: {question_id: question.id, id: voted_votable, format: :json } }
  end

  it_behaves_like 'Commentable' do
    let(:question) { create(:question) }
    let(:options) { { question_id: question.id } }
    let(:commentable) { create(:answer, question: question) }
  end
end
