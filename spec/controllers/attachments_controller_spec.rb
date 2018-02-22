require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'DELETE #destroy' do
    sign_in_user
    let(:author_question) { create(:question, user: @user, attachments: create_list(:attachment, 2)) }

    context 'author of attachment' do
      it 'delete attachment' do
        expect { delete :destroy, params: { id: author_question.attachments.first }}.to change(author_question.attachments, :count).by(-1)
      end
    end

    context 'not an author or attachment' do
      let(:question) { create(:question, attachments: create_list(:attachment, 2)) }
      it 'dont delete attachment' do
        expect { delete :destroy, params: { id: question.attachments.first }}.to change(question.attachments, :count).by(0)
      end
    end
  end
end
