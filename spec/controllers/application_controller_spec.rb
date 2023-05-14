describe ApplicationController do
  let(:user) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  describe "current_user" do
    it "returns current user if logged in" do
      user.save
      controller.session[:user_id]= user.id
      assert_equal user, controller.current_user
    end
    
    it "returns nil if not logged in" do
      controller.session[:user_id]= nil
      assert_equal nil, controller.current_user
    end
  end

  describe "logged_in?" do
    it "returns true if logged in" do
      user.save
      controller.session[:user_id]= user.id
      assert controller.logged_in?
    end
    
    it "returns false if not logged in" do
      controller.session[:user_id]= nil
      assert_equal controller.logged_in?, false
    end
  end

  describe "authorized" do
    it "redirect to login path if not logged in" do
      expect(controller).to receive(:redirect_to)
      controller.session[:user_id]= nil
      controller.authorized
    end
    
    it "does not redirect if logged in" do
      user.save
      controller.session[:user_id]= user.id
      expect(controller.authorized).not_to receive(:redirect_to)
    end
  end
end
