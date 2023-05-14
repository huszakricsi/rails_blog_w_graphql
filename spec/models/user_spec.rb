describe User do
  subject { described_class.new }

  let(:valid_subject) do
     subject.username = "Richard"
     subject.email= "email@email.com"
     subject.password= "1234567890"
     subject.password_confirmation= "1234567890"
     subject.role= :admin
     subject
  end
  let(:comments) {[Comment.new(body: "Comment 1", author: valid_subject), Comment.new(body: "Comment 2", author: valid_subject)]}
  let(:post) { Post.new(author: valid_subject, title: 'Title', body: 'Body', comments: comments) }

  context "Validations" do 
    it "User creation fails without username, email and password attribute" do
      assert subject.invalid?
      assert_empty subject.errors.map(&:attribute) - [:username, :email, :password]
    end

    it "User creation succeeds" do
      assert valid_subject.valid?
      assert_empty valid_subject.errors
    end
  end

  context "Callbacks" do 
    it "Sets default role" do
      user = User.allocate
      expect(user).to receive(:set_default_role)
      user.send(:initialize)
    end
  end

  context "Associations" do 
    it "Users can have posts" do
      valid_subject.save
      post.save
      assert_equal valid_subject.posts, [post]
    end

    it "Users can have comments" do
      valid_subject.save
      post.save
      comments.each(&:save)
      assert_equal post.comments, valid_subject.comments
    end
  end
  context "Attribute" do
    it "Role" do
      assert_equal valid_subject.role, "admin"
    end
  end
end
