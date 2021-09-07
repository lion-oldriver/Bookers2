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
    Book.joins(:favorites).where(favorites: { created_at: 6.days.ago.beginning_of_day..Time.current}).group(:book_id).order("count(*) desc")
  end
  scope :latest, -> { order(id: :desc) }
  scope :rated, -> { order(rate: :desc) }
  scope :views, -> { order(impressions_count: :desc) }
  scope :created_today, -> { where(created_at: Time.zone.now.beginning_of_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.beginning_of_day..1.days.ago.end_of_day) }
  scope :created_this_week, -> { where(created_at: 6.days.ago.beginning_of_day..Time.current) }
  scope :created_last_week, -> { where(created_at: 13.days.ago.beginning_of_day..7.days.ago.end_of_day) }
end
