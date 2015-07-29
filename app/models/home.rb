class Home < ActiveRecord::Base
  accepts_nested_attributes_for :cards
end
