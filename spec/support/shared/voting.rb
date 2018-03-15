shared_examples_for "Votable" do
  describe 'POST #upvote #downvote' do
    context 'Authenticated user' do
      sign_in_user

      it 'adds positive vote to votable' do
        expect { post :upvote, params: { id: votable }.merge(options), format: :json }
            .to change(votable, :rating).by(1)
      end

      it 'adds negative vote to votable' do
        expect { post :downvote, params: { id: votable }.merge(options), format: :json }
            .to change(votable, :rating).by(-1)
      end

      it 'adds positive vote to his own votable' do
        expect { post :upvote, params: { id: my_votable}.merge(options), format: :json }
            .to change(my_votable, :rating).by(0)
      end
    end

    context 'Non-authenticated user' do
      it 'tries to add vote' do
        expect { post :upvote, params: { id: votable, rate: 1 }.merge(options), format: :json }
            .to change(votable, :rating).by(0)
      end
    end
  end

  describe 'DELETE #unvote' do
    sign_in_user
    let!(:vote) { create(:vote, votable: voted_votable, user: @user, rate: 1) }

    it 'remove current_user`s vote' do
      expect { delete_request }.to change(voted_votable.votes, :count).by(-1)
    end
  end
end
