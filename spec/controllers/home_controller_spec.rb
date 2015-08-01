require "rails_helper"

describe "On sumbit main page" do
  it "review text must not be equal to original" do
    card = Card.new(original_text: "Ja ja")
    expect(card.check_translation("das ist fantastish!")).to be false
  end
end
