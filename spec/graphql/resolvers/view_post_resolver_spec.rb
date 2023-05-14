RSpec.describe "query viewPost" do
  let(:admin) {User.create(username: "Emily", role: :admin, email: "emily@email.com", password: "12345678910", password_confirmation: "12345678910")}
  let(:post) { Post.create(author: admin, title: 'asd', body: 'Body', tag_names_array: ['t2']) }
  let (:posts_query) do
    <<~GQL
    query {
      viewPost(
        id: #{post.id}
      ) {
        id
        title
        body
        author {
          username
        }
        tags {
          name
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
    result = RailsBlogWGraphqlSchema.execute(posts_query, context: context)
    assert_equal result.dig("data", "viewPost"), {"id"=>"#{post.id}", "title"=>"asd", "body"=>"Body", "author"=>{"username"=>"Emily"}, "tags"=>[{"name"=>"t2"}]}
  end
end
