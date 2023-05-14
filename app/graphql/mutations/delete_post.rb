module Mutations
  class DeletePost < BaseMutation

    argument :id, ID, required: true

    type String

    def resolve(id: nil)
      post = Post.find(id)
      raise GraphQL::ExecutionError.new("Insufficent permissions") unless PostsDeletionPolicy.delete?(context[:current_user], post)
      PostsDeletionService.call(post)
      'Post deleted'
    end
    
    def self.authorized?(object, context)
      super && context[:current_user].present? && PostsDeletionPolicy.delete?(context[:current_user])
    end
    
    def self.visible?(context)
      super && context[:current_user].present? && PostsDeletionPolicy.delete?(context[:current_user])
    end
  end
end
