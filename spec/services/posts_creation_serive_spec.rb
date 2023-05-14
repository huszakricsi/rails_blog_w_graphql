describe PostsCreationService do
  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post_params) { {body: 'post body', title: 'post title', tags_attributes: [tag_name]} }
  let(:tag_name) { "its a tag" }
  context "call" do 
    it "creates a post with tags and attributes" do
      post = described_class.call(author, post_params)
      assert_equal post.body, post_params[:body]
      assert_equal post.title, post_params[:title]
      assert_equal post.author, author
      assert_equal post.tags.map(&:name), [tag_name]
    end
  end
end
