require "rails_helper"

describe Category do
  before(:each) do
    @category = FactoryGirl.create(:category)
  end
  it "should create a valid factory" do
    expect(@category).to be_valid
  end
  it "should be inactive" do
    expect(@category.set_category_inactive).to be true
  end

  it "should be active" do
    expect(@category.set_category_active).to be true
  end

  it "categories count should be less or equal 1" do
    @categories = Category.active_category.count
    expect(@categories).to be <= 1
  end
end
