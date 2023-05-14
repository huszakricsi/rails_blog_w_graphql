describe UsersController do
  let(:valid_attributes) { { username: "Richard", role: 'admin', email: "email@email.com", password: "1234567890", password_confirmation: "1234567890" } }

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {:user => valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "redirects to the posts" do
        post :create, params: {:user => valid_attributes}
        expect(response).to redirect_to(posts_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, params: {:user => {name: "a"}}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:user => {name: "a"}}
        expect(response).to redirect_to signup_path
      end
    end
  end
end
