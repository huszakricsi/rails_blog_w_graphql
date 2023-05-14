module Types
  class PostType < BaseObject
    field :id, ID, null: false #in a more serious environment, its better to use a UUID 
    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false
    field :author, UserType, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :comments, [CommentType]
    field :tags, [TagType]
  end
end
