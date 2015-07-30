class Card < ActiveRecord::Base
  scope :created_before, -> (data) { where("review_date <= ?", data) }

  validates_with StringCompare
  validates :original_text, :translated_text, :review_date, presence: true
    
  after_validation :set_review_date, on: [:create]
  
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
    review_date = 3.days.from_now
  end
end
