class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  
  validates :username, presence: true, allow_blank: false, uniqueness: true
  validates :email, presence: true
  validates :password, length: { minimum: 8 }

  enum role: [:user, :writer, :editor, :admin]
  
  after_initialize :set_default_role, :if => :new_record?

  attr_accessor :token

  has_secure_password

  def set_default_role
    self.role ||= :user
  end
end
