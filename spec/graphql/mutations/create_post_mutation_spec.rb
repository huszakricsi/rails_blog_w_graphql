RSpec.describe "mutation createPost" do
  let (:create_post_mutation) do
    <<~GQL
    mutation {
      createPost(
        input: {title: "title", body: "body"}
      ) {
        id
        title
        body
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

  let(:admin) {User.create!(username: "Emily", role: :admin, email: "emily@email.com", password: "12345678910", password_confirmation: "12345678910")}

  it "creates a post" do
    expect {
      RailsBlogWGraphqlSchema.execute(create_post_mutation, context: context)
    }.to change(Post, :count).by(1)
  end

  it "creates a post and returns its attributes" do
    result = RailsBlogWGraphqlSchema.execute(create_post_mutation, context: context)
    assert_equal result.dig("data", "createPost"), {"id"=>"#{Post.last.id}", "title"=>"title", "body"=>"body"}
  end
end
