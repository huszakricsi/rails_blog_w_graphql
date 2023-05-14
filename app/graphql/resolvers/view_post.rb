module Resolvers
  class ViewPost < Resolvers::BaseResolver
    
    type Types::PostType, null: false

    argument :id, ID, required: true

    def resolve(id: nil)
      Post.find(id)
    end

    def self.authorized?(object, context)
      super && context[:current_user].present?
    end
    
    def self.visible?(context)
      super && context[:current_user].present?
    end
  end
end
