describe PostsUpdateService do
  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post) { Post.create(author: author, title: 'Title', body: 'Body') }
  let(:new_body) { 'new body' }
  let(:new_title) { 'new title' }
  let(:update_attributes) { {body: new_body, title: new_title}}
  context "call" do 
    it "updates a post with tags and attributes" do
      described_class.call(post.id, update_attributes)
      post.reload
      assert_equal post.body, new_body
      assert_equal post.title, new_title
    end
  end
end
