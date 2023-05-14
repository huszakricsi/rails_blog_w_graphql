class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :post

  validates :post, presence: true
  validates :tag,  presence: true, uniqueness: { scope: :post_id }
end
