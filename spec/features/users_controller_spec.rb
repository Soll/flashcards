require "rails_helper"

describe UsersController do
	before :each do
    @user = FactoryGirl.create(:user)
  end
end
