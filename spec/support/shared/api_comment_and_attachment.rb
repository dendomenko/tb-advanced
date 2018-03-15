shared_examples_for 'comment and attachment' do
  context 'comments' do
    it 'included in question object' do
      expect(response.body).to have_json_size(1).at_path(path + 'comments')
    end

    %w[id text user_id].each do |attr|
      it "comment object contains #{attr}" do
        expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path(path + "comments/0/#{attr}")
      end
    end
  end

  context 'attachments' do
    it 'included in question object' do
      expect(response.body).to have_json_size(1).at_path(path + 'attachments')
    end

    it "attachment object contains url" do
      expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path(path + 'attachments/0/url')
    end
  end
end