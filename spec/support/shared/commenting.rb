shared_examples_for "Commentable" do
  describe 'POST #comment' do
    sign_in_user
    it 'add current_user comment to question' do
      expect { post :comment, params: { id: commentable, comment: attributes_for(:comment) }.merge(options) }
          .to change(Comment, :count).by(1)
    end
  end
end
