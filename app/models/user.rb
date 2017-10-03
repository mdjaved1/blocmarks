class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_bookmarks, through: :likes, source: :bookmark

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end