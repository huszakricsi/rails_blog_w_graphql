describe SessionsController do
  let(:valid_attributes) { { username: "richard", email: "email@email.com", password: "1234567890" } }

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a session and redirects to posts_path" do
        User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890")
        post :create, params: valid_attributes
        expect(response).to redirect_to(posts_path)
      end
    end

    describe "with invalid params" do
      it "redirects to login path" do
        post :create, params: {name: "a"}
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST destroy" do
    it "destroys the session and redirects to login path" do
      User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890")
      post :create, params: valid_attributes
      expect(response).to redirect_to(posts_path)
      post :destroy, params: valid_attributes
      expect(response).to redirect_to(login_path)
    end
  end
end
