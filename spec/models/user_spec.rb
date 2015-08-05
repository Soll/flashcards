require "rails_helper"

describe User do
  it "should create valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
end
