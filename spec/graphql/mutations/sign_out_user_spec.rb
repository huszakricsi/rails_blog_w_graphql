RSpec.describe "mutation signOutUser" do
  let (:sign_out_user_mutation) do
    <<~GQL
    mutation {
      signOutUser(
        input: {}
      ) {
        token
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

  it "logs the user if credentials are correct" do
    result = RailsBlogWGraphqlSchema.execute(sign_out_user_mutation, context: context)
    assert_equal result.dig("data", "signOutUser", "token"), nil
  end
end
