RSpec.describe "mutation signInUser" do
  let (:valid_sign_in_user_mutation) do
    <<~GQL
    mutation {
      signInUser(
        input: {credentials: {email: "emily@email.com", password: "12345678910"}}
      ) {
        user {
          id
          role
          username
        }
        token
      }
    }
    GQL
  end

  let (:invalid_sign_in_user_mutation) do
    <<~GQL
    mutation {
      signInUser(
        input: {credentials: {email: "emily@email.com", password: "abcdefghiklmnop"}}
      ) {
        user {
          id
          role
          username
        }
        token
      }
    }
    GQL
  end

  let(:context) do
    {
      session: {},
      current_user: nil
    }
  end

  let!(:admin) {User.create!(username: "Emily", role: :admin, email: "emily@email.com", password: "12345678910", password_confirmation: "12345678910")}

  it "logs in user if credentials are correct" do
    result = RailsBlogWGraphqlSchema.execute(valid_sign_in_user_mutation, context: context)
    assert_equal result.dig("data", "signInUser", "user", "username"), admin.username
  end

  it "returns an error when authentication fails" do
    result = RailsBlogWGraphqlSchema.execute(invalid_sign_in_user_mutation, context: context)
    assert_equal result.dig("data", "signInUser"), nil
  end


end