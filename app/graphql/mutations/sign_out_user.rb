module Mutations
  class SignOutUser < BaseMutation
    null true

    field :token, String, null: true

    def resolve
      context[:session][:token] = nil
      { token: context[:session][:token] }
    end
  end
end
