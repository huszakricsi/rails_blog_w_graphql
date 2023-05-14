module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :posts, resolver: Resolvers::Posts
    field :view_post, resolver: Resolvers::ViewPost
    field :current_username, String,
      description: "Returns the logged in users username"
    def current_username
      context[:current_user]&.username
    end
  end
end
