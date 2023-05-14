RSpec.describe "mutation deletePost" do
  let(:admin) {User.create(username: "Emily", role: :admin, email: "emily@email.com", password: "12345678910", password_confirmation: "12345678910")}
  let(:post) { Post.create(author: admin, title: 'Title', body: 'Body') }
  let (:delete_post_mutation) do
    <<~GQL
    mutation {
      deletePost(
        input: {id: #{post.id}}
      )
    }
    GQL
  end

  let(:context) do
    {
      session: {token: "token"},
      current_user: admin
    }
  end

  let(:admin) {User.create!(username: "Emily", role: :admin, email: "emily@email.com", password: "12345678910", password_confirmation: "12345678910")}

  it "deletes a post" do
    post
    expect {
      RailsBlogWGraphqlSchema.execute(delete_post_mutation, context: context)
    }.to change(Post, :count).by(-1)
  end

  it "deletes a post and returns that its deleted" do
    result = RailsBlogWGraphqlSchema.execute(delete_post_mutation, context: context)
    assert_equal result.dig("data", "deletePost"), "Post deleted"
  end
end
