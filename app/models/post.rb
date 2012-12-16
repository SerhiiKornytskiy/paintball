class Post < ActiveRecord::Base
  belongs_to :user	
  has_many :comments, :dependent => :destroy


  attr_accessible :body, :title, :user_id, :video
  
  validates :body, :title , :presence => true 

  def code
  	if self.video
  	  if self.video.match(/(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?(\w{10,})/)
        (self.video.split("=").second).split("&").first 
      else
         self.video = nil   
      end
    end
  end

end
