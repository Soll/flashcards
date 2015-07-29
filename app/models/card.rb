class Card < ActiveRecord::Base
  validates_with TextCompare
  validates :original_text, :translated_text, :review_date, presence: true
  
  after_validation :set_review_date, on: [:create]

  protected
  def set_review_date
    self.review_date = 3.days.from_now
  end
end
