require "rails_helper"

describe CardMailer do
  it "send emails" do
    user = FactoryGirl.create(:user)
    email = CardMailer.send_expired_cards(user.email).deliver_now
    expect(ActionMailer::Base.deliveries.empty?).to be false
    expect(email.from).to eq(["new-cards@flashcards.com"])
    expect(email.to).to eq(["user@mail.ru"])
  end
end
