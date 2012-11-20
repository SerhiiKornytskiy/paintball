class Album < ActiveRecord::Base
attr_accessible :name
belongs_to :user
has_many :photos, :dependent => :destroy

validates_presence_of :name

end
