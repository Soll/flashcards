class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :cards, dependent: :destroy

  validates :email, :crypted_password, presence: true
  validates :email, uniqueness: true
end
