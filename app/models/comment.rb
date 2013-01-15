class Comment < ActiveRecord::Base
  attr_accessible :user_id, :post_id, :content
  validates :user_id, :post_id, :content, :presence => true
  belongs_to :user
  belongs_to :post
end
