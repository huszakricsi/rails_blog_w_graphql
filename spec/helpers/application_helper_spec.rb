describe ApplicationHelper do

  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:author2) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:post) { Post.create(author: author, title: 'Title', body: 'Body', tags: [tag1]) }
  let(:tag1) {Tag.create(name: "Tag 1")}
  let(:tag2) {Tag.create(name: "Tag 2")}

  context "Methods" do 
    it "usernames_that_have_posts returns only users with posts" do
      author
      author2
      post
      assert_equal usernames_that_have_posts, [author.username]
    end

    it "tag_names_that_have_posts returns only tag names with posts" do
      tag1
      post
      assert_equal tag_names_that_have_posts, [tag1.name]
    end
  end
end
