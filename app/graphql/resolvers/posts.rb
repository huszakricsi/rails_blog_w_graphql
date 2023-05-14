module Resolvers
  class Posts < Resolvers::BaseResolver
    
    type [Types::PostType], null: false

    argument :title, String, required: false
    argument :author_username, String, required: false
    argument :tag_titles, [String], required: false

    def resolve(title: nil, author_username: nil, tag_titles: nil)
      PostsQueryService.call({title: title, author_username: author_username, tag_titles: tag_titles})
    end

    def self.authorized?(object, context)
      super && context[:current_user].present?
    end
    
    def self.visible?(context)
      super && context[:current_user].present?
    end
  end
end
