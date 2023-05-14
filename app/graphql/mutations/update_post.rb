module Mutations
  class UpdatePost < BaseMutation

    argument :id, ID, required: true
    argument :title, String, required: false
    argument :body, String, required: false
    argument :tag_names_array, [String], required: false

    type Types::PostType

    def resolve(id: nil, title: nil, body: nil, tag_names_array: nil)
      post = Post.find(id)
      raise GraphQL::ExecutionError.new("Insufficent permissions") unless PostsUpdatePolicy.update?(context[:current_user], post)
      update_attributes = {title: title, body: body, tag_names_array: tag_names_array}.compact
      PostsUpdateService.call(post, update_attributes)
      post
    end
    
    def self.authorized?(object, context)
      super && context[:current_user].present? && PostsUpdatePolicy.update?(context[:current_user])
    end
    
    def self.visible?(context)
      super && context[:current_user].present? && PostsUpdatePolicy.update?(context[:current_user])
    end
  end
end
