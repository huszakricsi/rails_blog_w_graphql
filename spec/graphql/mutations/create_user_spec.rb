RSpec.describe "mutation createUser" do
  let (:user_creation_mutation) do
    <<~GQL
    mutation {
      createUser(
        input: {username: "new_username", role: "admin", authProvider: {credentials: {email: "new_user_email@example.com", password: "1234567890"}}}
      ) {
        id
        username
        email
        role
      }
    }
    GQL
  end
  let (:invalid_user_creation_mutation) do
    <<~GQL
    mutation {
      createUser(
        input: {username: "1", role: "admin", authProvider: {credentials: {email: "", password: "2"}}}
      ) {
        id
        username
        email
        role
      }
    }
    GQL
  end

  it "creates a new user" do
    result = RailsBlogWGraphqlSchema.execute(user_creation_mutation)
    user = result.dig("data", "createUser")
    assert_equal user["username"], "new_username"
  end

  it "fails to create a new user and shows errors" do
    result = RailsBlogWGraphqlSchema.execute(invalid_user_creation_mutation)
    assert result["errors"]
  end
end