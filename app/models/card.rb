class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  mount_uploader :avatar, AvatarUploader

  scope :created_before, -> (data) { where("review_date <= ?", data) }
  scope :from_active_category, -> { joins(:category).where("categories.active = true") }

  validates :original_text, :translated_text,
            :review_date, :user_id, :category_id, presence: true
  validates_with StringCompare

  before_validation :set_review_date, on: [:create]

  def self.random_record_from_active_category
    offset(rand(Card.from_active_category.created_before(Time.now).count)).first
  end

  def self.random_record
    offset(rand(Card.created_before(Time.now).count)).first
  end

  def set_new_review_date
    update_column(:review_date, 3.days.from_now)
  end

  def check_translation(review_text)
    original_text.mb_chars.downcase == review_text.mb_chars.downcase
  end

  protected
  def set_review_date
    self.review_date = 3.days.from_now
  end
end
