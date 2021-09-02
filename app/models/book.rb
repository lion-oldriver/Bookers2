class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  scope :latest, -> { order(id: :desc) }
  scope :rated, -> { order(rate: :desc) }

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
end
