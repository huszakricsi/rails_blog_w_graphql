describe PostsDeletionPolicy do
  let(:post) { Post.new(title: 'Title', body: 'Body') }
  let(:user) { User.create(username: "Richard", role: :user) }
  let(:writer) { User.create(username: "Joe", role: :writer) }
  let(:editor) { User.create(username: "Peter", role: :editor) }
  let(:admin) { User.create(username: "Emily", role: :admin) }

  context "Checks" do 
    it "Lets you delete a post when you are an editor and also the author of the post" do
      post.author= editor
      assert described_class.delete?(editor, post)
    end
    
    it "Lets you delete a post when you are an admin" do
      assert described_class.delete?(admin, post)
    end
    
    it "Denies you delete a post when you are an editor" do
      assert_equal described_class.delete?(editor, post), false
    end
    
    it "Denies post creation in case you are a writer" do
      post.author= writer
      assert_equal described_class.delete?(writer, post), false
    end
  
    it "Denies post creation in case you are a user" do
      post.author= user
      assert_equal described_class.delete?(user, post), false
    end
  end
end
