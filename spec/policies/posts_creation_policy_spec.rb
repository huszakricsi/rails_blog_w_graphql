describe PostsCreationPolicy do
  let(:user) { User.create(username: "Richard", role: :user) }
  let(:writer) { User.create(username: "Joe", role: :writer) }
  let(:editor) { User.create(username: "Peter", role: :editor) }
  let(:admin) { User.create(username: "Emily", role: :admin) }

  context "Checks" do 
    it "Lets you create a post when you are a writer" do
      assert described_class.create?(writer)
    end

    it "Lets you create a post when you are a editor" do
      assert described_class.create?(editor)
    end

    it "Lets you create a post when you are a admin" do
      assert described_class.create?(admin)
    end

    it "Denies post creation in case you are not eligible" do
      assert_equal described_class.create?(user), false
    end
  end
end
