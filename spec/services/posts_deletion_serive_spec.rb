describe PostsDeletionService do
  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post) { Post.create(author: author, title: 'Title', body: 'Body', tag_names_array: [ "its a tag"]) }
  context "call" do 
    it "deletes a post and its relations to tags" do
      post
      assert_equal Post.count, 1
      described_class.call(post)
      assert_equal Post.count, 0
    end
  end
end
