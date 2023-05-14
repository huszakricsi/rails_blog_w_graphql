RSpec.describe "mutation updatePost" do
  let(:admin) {User.create(username: "Emily", role: :admin, email: "emily@email.com", password: "12345678910", password_confirmation: "12345678910")}
  let(:post) { Post.create(author: admin, title: 'Title', body: 'Body') }
  let (:update_post_mutation) do
    <<~GQL
    mutation {
      updatePost(input: {id: #{post.id}, title: "new", body: "new", tagNamesArray: ["apple2"]}) {
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
    result = RailsBlogWGraphqlSchema.execute(update_post_mutation, context: context)
    assert_equal result.dig("data", "updatePost"), {"title"=>"new", "body"=>"new", "author"=>{"username"=>"Emily"}, "tags"=>[{"name"=>"apple2"}]}
  end
end
