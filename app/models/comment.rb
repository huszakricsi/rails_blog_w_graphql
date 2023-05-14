class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :user, foreign_key: 'author_id', class_name: 'User'
  belongs_to :post

  validates :author, presence: true
  validates :post, presence: true
  validates :body, presence: true, allow_blank: false
end
