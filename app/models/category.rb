class Category < ActiveRecord::Base
  has_many :cards, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :active_category, -> { where(active: true) }
  
  def self.get_active_category
    active_category.first
  end

  def set_category_active
    self.update_column(:active, true)
  end

  def set_category_inactive
    self.update_column(:active, false)
  end

  def category_status
    self.active ? "Текущая" : "-"
  end
end
