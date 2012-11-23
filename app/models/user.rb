class User < ActiveRecord::Base
  has_many :albums
  has_many :comments
  has_many :posts
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  validates :admin, :uniqueness => true
  attr_accessible :email, :password, :password_confirmation, :remember_me 


 end
