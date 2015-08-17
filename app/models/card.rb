class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  attr_accessor :data, :review_text

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

  def set_term(level)
    @term =
    if level == 0
      12.hours.from_now
    elsif level == 1
      3.days.from_now
    elsif level == 2
      1.week.from_now
    elsif level == 3
      2.weeks.from_now
    elsif level == 4
      30.days.from_now
    end
  end

  def set_new_review_date
    update_column(:review_date, set_term(cur_level))
  end

  def reset_bad_attempts
    update_column(:bad_attempts, 0)
  end

  def inc_bad_attempts
    update_column(:bad_attempts, bad_attempts + 1) if bad_attempts < 3
  end

  def up_level
    update_column(:cur_level, cur_level + 1) if cur_level < 4
  end

  def down_level
    update_column(:cur_level, cur_level - 1) if cur_level > 0
  end

  def look_for_similar(review_text)
    ActiveRecord::Base.connection.query(%(
      SELECT original_text AS s_text, 
      similarity(original_text, '#{review_text}') AS distance
      FROM cards WHERE original_text % '#{review_text}'
      ORDER BY distance DESC
    ))
  end

  def check_translation(review_text)
    @data = look_for_similar(review_text)

    if @data.count > 0
      reset_bad_attempts
      set_new_review_date
      up_level
    else
      inc_bad_attempts
      if bad_attempts == 3
        reset_bad_attempts
        down_level
        set_new_review_date
      end
    end
    @data.any?
  end

  protected
  def set_review_date
    self.review_date = Time.now
  end
end
