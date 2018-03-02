require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'builds new answer form' do
      expect(assigns(:answer_form)).to be_a(AnswerForm)
    end


    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new QuestionForm to @question_form' do
      expect(assigns(:question_form)).to be_a(QuestionForm)
    end


    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { question_form: attributes_for(:question) } }
            .to change(Question, :count).by(1)
      end

      # it 'redirects to show view' do
      #   post :create, params: { question_form: attributes_for(:question) }
      #   expect(response).to redirect_to question_path(assigns(:question))
      # end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect do
          post :create, params: { question_form: attributes_for(:invalid_question) }
        end.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_form: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before { question }
    let!(:user_question) { create(:question, user: @user) }

    it 'deletes user question' do
      expect { delete :destroy, params: { id: user_question } }
          .to change(Question, :count).by(-1)
    end

    it 'fail delete another\'s user' do
      expect { delete :destroy, params: { id: question } }
          .to change(Question, :count).by(0)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    let(:question) { create(:question, user: @user) }

    it 'assings the requested question to @question' do
      patch :update, params: { id: question,
                               question: attributes_for(:question) },
            format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes question attributes' do
      patch :update, params: { id: question,
                               question: { title: 'new title',
                                           body: 'new body' } }, format: :js
      question.reload
      expect(question.title).to eq 'new title'
      expect(question.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: { id: question,
                               question: attributes_for(:question) },
            format: :js
      expect(response).to render_template :update
    end
  end

  describe 'POST #upvote #downvote' do

    let(:question) { create(:question) }
    context 'Authenticated user' do
      sign_in_user
      let(:my_question) { create(:question, user: @user) }

      it 'adds positive vote to question' do
        expect { post :upvote, params: { id: question }, format: :json }
            .to change(question, :rating).by(1)
      end

      it 'adds negative vote to question' do
        expect { post :downvote, params: { id: question }, format: :json }
            .to change(question, :rating).by(-1)
      end

      it 'adds positive vote to his own question' do
        expect { post :upvote, params: { id: my_question}, format: :json }
            .to change(question, :rating).by(0)
      end
    end

    context 'Non-authenticated user' do
      it 'tries to add vote' do
        expect { post :upvote, params: { id: question, rate: 1 }, format: :json }
            .to change(question, :rating).by(0)
      end
    end
  end

  describe 'DELETE #unvote' do
    sign_in_user
    let(:another_user) { create(:user) }
    let(:question) { create(:question, user: another_user) }
    let!(:vote) { create(:vote, votable: question, user: @user, rate: 1) }
    let(:delete_request) { delete :unvote, params: { id: question, format: :json } }

    it 'remove current_user`s vote' do
      expect { delete_request }.to change(question.votes, :count).by(-1)
    end
  end

  describe 'POST #comment' do
    sign_in_user
    let(:question) { create(:question) }
    it 'add current_user comment to question' do
      expect { post :comment, params: { id: question, comment: attributes_for(:comment) } }
        .to change(Comment, :count).by(1)
    end
  end
end
