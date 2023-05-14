describe CommentsCreationService do
  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post) { Post.create(author: author, title: 'Title', body: 'Body') }
  let(:comment_body) {"comment body"}
  context "call" do 
    it "creates a comment on a post and sets you as author, and the passed post id as post" do
      comment = described_class.call(author, post.id, comment_body)
      assert_equal comment.body, comment_body
      assert_equal comment.author, author
      assert_equal comment.post, post
    end
  end
end
