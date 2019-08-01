class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 250 }
  default_scope { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
end
