class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :relationships, foreign_key: 'user_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  validates :name,length: { in: 2..20 }
  validates :name,uniqueness: true
  validates :introduction,length: { maximum: 50 }

  def follow(user_id)
    relationships.create(follow_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(follow_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
