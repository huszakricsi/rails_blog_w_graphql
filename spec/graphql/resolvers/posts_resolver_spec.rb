RSpec.describe "query Posts" do
  let(:admin) {User.create(username: "Emily", role: :admin, email: "emily@email.com", password: "12345678910", password_confirmation: "12345678910")}
  let(:post) { Post.create(author: admin, title: 'asd', body: 'Body', tag_names_array: ['t2']) }
  let(:posts) {[Post.create(author: admin, title: 'Title', body: 'Body', tag_names_array: ['t']), Post.create(author: admin, title: 'Title', body: 'Body', tag_names_array: ['t']), Post.create(author: admin, title: 'Title', body: 'Body', tag_names_array: ['t']), Post.create(author: admin, title: 'Title', body: 'Body', tag_names_array: ['t'])] }
  let (:posts_query) do
    <<~GQL
    query {
      posts(
        authorUsername: "Emily"
        tagTitles: ["t"]
        title: "Ti"
      ) {
        id
        title
        body
        author {
          username
        }
        comments {
          body
          author {
            username
          }
        }
      }
    }
    GQL
  end

  let(:context) do
    {
      session: {token: "token"},
      current_user: admin
    }
  end

  it "updates a post and returns its attributes" do
    posts
    post
    result = RailsBlogWGraphqlSchema.execute(posts_query, context: context)
    assert_equal result.dig("data", "posts").count, posts.count
  end
end
