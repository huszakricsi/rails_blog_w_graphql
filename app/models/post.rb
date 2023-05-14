class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :user, foreign_key: 'author_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :author, presence: true
  validates :title, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false

  scope :title_search, ->(title) { where("title LIKE ?", "%#{title}%") }
  scope :author_search, ->(author_username) { includes(:author).where(author: {username: author_username}) }
  scope :tags_search, ->(tag_titles) { includes(:tags).where({tags: {name: tag_titles}}) }

  paginates_per 10

  #accepts_nested_attributes_for does not support find_or_create_by
  def tags_attributes=(attrs)
    return unless attrs
    existing_tags = attrs.map{|attr| Tag.find_or_create_by(name: attr)}
    self.tags = existing_tags
  end

  def tags_attributes
    tags.map(&:name).join(',')
  end
end
