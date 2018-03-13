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

  describe 'POST #upvote #downvote' do

    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }
    context 'Authenticated user' do
      sign_in_user
      let(:my_answer) { create(:answer, question: question, user: @user) }

      it 'adds positive vote to question' do
        expect { post :upvote, params: { question_id: question.id, id: answer }, format: :json }
            .to change(answer, :rating).by(1)
      end

      it 'adds negative vote to question' do
        expect { post :downvote, params: { question_id: question.id, id: answer}, format: :json }
            .to change(answer, :rating).by(-1)
      end

      it 'adds positive vote to his own question' do
        expect { post :upvote, params: { question_id: question.id, id: my_answer }, format: :json }
            .to change(answer, :rating).by(0)
      end
    end

    context 'Non-authenticated user' do
      it 'tries to add vote' do
        expect { post :upvote, params: { question_id: question.id, id: answer }, format: :json }
            .to change(answer, :rating).by(0)
      end
    end
  end

  describe 'DELETE #unvote' do
    sign_in_user
    let(:another_user) { create(:user) }
    let(:question) {create(:question)}
    let(:answer) { create(:answer, question:question, user: another_user) }
    let!(:vote) { create(:vote, votable: answer, user: @user, rate: 1) }
    let(:delete_request) { delete :unvote, params: { id: answer, question_id: question, format: :json } }

    it 'remove current_user`s vote' do
      expect { delete_request }.to change(answer.votes, :count).by(-1)
    end
  end

  describe 'POST #comment' do
    sign_in_user
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question:question) }
    it 'add current_user comment to answer' do
      expect { post :comment, params: { id: answer, question_id: question, comment: attributes_for(:comment) } }
          .to change(Comment, :count).by(1)
    end
  end
end
