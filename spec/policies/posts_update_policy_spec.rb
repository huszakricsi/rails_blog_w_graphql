describe PostsUpdatePolicy do
  let(:post) { Post.new(title: 'Title', body: 'Body') }
  let(:user) { User.create(username: "Richard", role: :user) }
  let(:writer) { User.create(username: "Joe", role: :writer) }
  let(:editor) { User.create(username: "Peter", role: :editor) }
  let(:admin) { User.create(username: "Emily", role: :admin) }

  context "Checks" do 
    it "Lets you update a post when you are a writer and also the author of the post" do
      post.author= writer
      assert described_class.update?(writer, post)
    end
    
    it "Lets you update a post when you are an editor" do
      assert described_class.update?(editor, post)
    end
    
    it "Lets you update a post when you are an admin" do
      assert described_class.update?(admin, post)
    end
    
    it "Denies post creation in case you are not eligible" do
      post.author= user
      assert_equal described_class.update?(user, post), false
    end
    
    it "Denies post creation in case you are writer and not author" do
      post.author= editor
      assert_equal described_class.update?(writer, post), false
    end
  end
end
