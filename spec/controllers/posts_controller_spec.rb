describe PostsController do
  let(:valid_attributes) { { body: 'body', title: 'title' } }
  let(:author) { User.create(username: "Richard", role: 'admin', email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post_) { Post.create(author: author, title: 'Title', body: 'Body') }

  before(:each) do
    controller.session[:user_id] = author.id
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new, {}
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "GET show" do
    it "shows the post" do
      get :show, params: {id: post_.id}
      assert_equal assigns(:post).id, post_.id
    end
  end

  describe "GET edit" do
    it "edits the post" do
      get :edit, params: {id: post_.id}
      assert_equal assigns(:post).id, post_.id
    end
  end

  describe "POST update" do
    it "updates a post" do
      patch :update, params: {id: post_.id, post: {title: 'new title', body: 'new-new body'}}
      assert_equal post_.reload.title, 'new title'
      assert_equal post_.reload.body, 'new-new body'
    end
  end
  
  describe "Delete" do
    it "Deletes a post" do
      post_
      expect {
        delete :delete, params: {id: post_.id}
      }.to change(Post, :count).by(-1)
    end
  end

  describe "POST create" do
    it "creates a post" do
      expect {
        post :create, params: {post: valid_attributes}
      }.to change(Post, :count).by(1)
    end

    it "redirects to login path" do
      post :create, params: {post: valid_attributes}
      expect(response).to redirect_to post_path(Post.last.id)
    end
  end
  
  describe "Index" do
    it "Lists posts" do
      post_
      get :index, params: {search_params: {title: 'title2'}}
      assert_equal assigns(:posts).pluck(:id), [post_.id]
    end
  end
end
