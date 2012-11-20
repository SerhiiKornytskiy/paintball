class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessible :image ,:name, :user_id, :album_id
  mount_uploader :image, ImageUploader
  validates_presence_of :image, :name
end
