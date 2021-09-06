class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
  is_impressionable counter_cache: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.last_week
    Book.joins(:favorites).where(favorites: { created_at: 7.days.ago..Time.current}).group(:book_id).order("count(*) desc")
  end
  scope :latest, -> { order(id: :desc) }
  scope :rated, -> { order(rate: :desc) }
  scope :views, -> { order(impressions_count: :desc) }
end
