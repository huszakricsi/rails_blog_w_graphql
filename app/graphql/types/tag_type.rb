module Types
  class TagType < BaseObject
    field :id, ID, null: false #in a more serious environment, its better to use a UUID 
    field :author, UserType, null: false
    field :name, String, null: false
  end
end
