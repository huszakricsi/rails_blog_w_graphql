describe PostsQueryService do
  let(:author) { User.create(username: "Richard", email: "email@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:author2) { User.create(username: "Peter", email: "email2@email.com", password: "1234567890", password_confirmation: "1234567890") }
  let(:posts) do
    [ Post.create(author: author, title: 'Title 1', body: 'Body', tag_names_array: ["its a tag"]),
      Post.create(author: author2, title: 'Title 2', body: 'Body', tag_names_array: ["its another tag"]),
      Post.create(author: author, title: 'Title 3', body: 'Body', tag_names_array: ["its a tag"]) ]
  end
  context "call" do 
    it "queries posts by author" do
      posts
      filtered_posts = described_class.call({author_username: author.username})
      assert_equal filtered_posts.count, 2
      assert_empty filtered_posts.pluck(:title) - ['Title 1', 'Title 3']
    end

    
    it "queries posts by tags" do
      posts
      filtered_posts = described_class.call({tag_titles: ['its a tag']})
      assert_equal filtered_posts.count, 2
      assert_empty filtered_posts.pluck(:title) - ['Title 3', 'Title 1']
    end

    
    it "queries posts by title" do
      posts
      filtered_posts = described_class.call({title: 'Title 3'})
      assert_equal filtered_posts.count, 1
      assert_empty filtered_posts.pluck(:title) - ['Title 3']
    end

    it "orders posts by newer to older" do
      posts
      filtered_posts = described_class.call
      assert filtered_posts.first.created_at > filtered_posts.last.created_at
    end
  end
end
