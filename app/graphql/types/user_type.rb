module Types
  class UserType < BaseObject
    field :id, ID, null: false #in a more serious environment, its better to use a UUID 
    field :created_at, DateTimeType, null: false
    field :username, String, null: false
    field :email, String, null: false
    field :role, String, null: false
  end
end
