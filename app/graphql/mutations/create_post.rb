module Mutations
  class CreatePost < BaseMutation

    argument :title, String, required: true
    argument :body, String, required: true
    argument :tag_names_array, [String], required: false

    type Types::PostType

    def resolve(title: nil, body: nil, tag_names_array: nil)
      post = PostsCreationService.call(context[:current_user], {title: title, body: body, tag_names_array: tag_names_array})
      raise GraphQL::ExecutionError.new("Invalid input: #{post.errors.full_messages.join(', ')}") if post.invalid?
      post
    end
    
    def self.authorized?(object, context)
      super && context[:current_user].present? && PostsCreationPolicy.create?(context[:current_user])
    end
    
    def self.visible?(context)
      super && context[:current_user].present? && PostsCreationPolicy.create?(context[:current_user])
    end
  end
end
