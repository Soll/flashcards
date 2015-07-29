class Card < ActiveRecord::Base
  scope :created_before, -> (data) { where("review_date <= ?", data) }

  validates_with StringCompare
  validates :original_text, :translated_text, :review_date, presence: true
  
  after_validation :set_review_date, on: [:create]
  
  def self.random_record
    c = Card.all.created_before(Time.now).count
    offset(rand(c)).first
  end

  def set_new_review_date
    update_column(:review_date, 3.days.from_now)
  end

  protected
  def set_review_date
    self.review_date = 3.days.from_now
  end
end
