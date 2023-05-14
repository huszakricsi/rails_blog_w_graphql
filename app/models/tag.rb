class Tag < ApplicationRecord
  has_many :taggings

  validates :name, uniqueness: true, presence: true, allow_blank: false
end
