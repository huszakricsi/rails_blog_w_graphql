describe CommentsController do
  let(:valid_attributes) { { body: 'body', post_id: post_.id } }
  let(:author) { User.create(username: "Richard", role: 'admin', email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post_) { Post.create(author: author, title: 'Title', body: 'Body') }

  before(:each) do
    controller.session[:user_id] = author.id
  end

  describe "POST create" do
    it "creates a comment" do
      expect {
        post :create, params: valid_attributes
      }.to change(Comment, :count).by(1)
    end

    it "redirects to login path" do
      post :create, params: valid_attributes
      expect(response).to redirect_to post_path(post_.id)
    end
  end
end
