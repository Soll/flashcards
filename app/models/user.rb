class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_many :cards, dependent: :destroy

  validates :email, :crypted_password, presence: true
  validates :email, uniqueness: true
end
