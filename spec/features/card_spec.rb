require 'rails_helper'

describe Card do
  it "has a valid factory" do
    expect(FactoryGirl.create(:card)).to be_valid
  end

  it "parameter original text can't be blank" do
    expect(FactoryGirl.build(:card, original_text: nil)).not_to be_valid
  end

  it "parameter translated text can't be blank" do
    expect(FactoryGirl.build(:card, translated_text: nil)).not_to be_valid
  end

  it "parameter review_date can't be blank" do
    expect(FactoryGirl.build(:card, review_date: nil)).not_to be_valid
  end

  it "must change date after correct translation" do
    card = FactoryGirl.create(:card)
    old_date = card.review_date
    card.set_new_review_date
    expect(card.review_date > old_date).to be true
  end

  it "review text must not be equal to original" do
    card = Card.new(original_text: "Ja ja")
    expect(card.check_translation("das ist fantastish!")).to be false
  end
end
