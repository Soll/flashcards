require "rails_helper"

describe Category do
  it "should create a valid factory" do
    expect(FactoryGirl.create(:category)).to be_valid
  end
end
