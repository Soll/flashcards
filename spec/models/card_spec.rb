require "rails_helper"

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

  it "user id can't be blank" do
    expect(FactoryGirl.build(:card, user_id: nil)).not_to be_valid
  end

  it "must change date after correct translation" do
    card = FactoryGirl.create(:card)
    old_date = card.review_date
    card.set_new_review_date
    expect(card.review_date > old_date).to be true
  end

  it "review text must not be equal to original" do
    card = FactoryGirl.create(:card, original_text: "Ja ja")
    expect(card.check_translation("das ist fantastish!")).to be false
  end

  it "must level up card when translation is correct" do
    card = FactoryGirl.create(:card)
    old_level = card.cur_level
    card.check_translation("das")
    expect(old_level < card.cur_level).to be true
  end

  it "must increase bad attempts when translation is incorrect" do
    card = FactoryGirl.create(:card)
    old_bad = card.bad_attempts
    card.check_translation("fann")
    expect(old_bad < card.bad_attempts).to be true
  end

  it "must down level card after 3 bad attempts" do
    card = FactoryGirl.create(:card, bad_attempts: 3, cur_level: 4)
    card.check_translation("fann")
    expect(card.cur_level).to be 3
  end

  it "must reset bad attempts after 3 bad attempts" do
    card = FactoryGirl.create(:card, bad_attempts: 3, cur_level: 4)
    card.check_translation("fann")
    expect(card.bad_attempts).to be 0
  end

  it "must reset bad attempts after any corect translation" do
    card = FactoryGirl.create(:card, bad_attempts: 2)
    card.check_translation("das")
    expect(card.bad_attempts).to be 0
  end

  it "level must be not more than 4" do
    card = FactoryGirl.create(:card, cur_level: 4)
    card.up_level
    expect(card.cur_level).to be 4
  end

  it "bad attempts must be not more than 3" do
    card = FactoryGirl.create(:card, bad_attempts: 3)
    card.inc_bad_attempts
    expect(card.bad_attempts).to be 3
  end

  it "level 0 set review_date +12 hours" do
    card = FactoryGirl.create(:card)
    old_date = Time.now
    card.set_new_review_date
    expect((card.review_date - old_date).to_i).to be 12.hours.to_i
  end

  it "level 1 set review_date +3 days" do
    card = FactoryGirl.create(:card, cur_level: 1)
    old_date = Time.now
    card.set_new_review_date
    expect((card.review_date - old_date).to_i).to be 3.days.to_i
  end

  it "level 2 set review_date +1 week" do
    card = FactoryGirl.create(:card, cur_level: 2)
    old_date = Time.now
    card.set_new_review_date
    expect((card.review_date - old_date).to_i).to be 1.week.to_i
  end

  it "level 3 set review_date +2 weeks" do
    card = FactoryGirl.create(:card, cur_level: 3)
    old_date = Time.now
    card.set_new_review_date
    expect((card.review_date - old_date).to_i).to be 2.week.to_i
  end

  it "level 4 set review_date +1 month" do
    card = FactoryGirl.create(:card, cur_level: 4)
    old_date = Time.now
    card.set_new_review_date
    expect((card.review_date - old_date).to_i).to be 30.days.to_i
  end

  it "look for similar cards" do
    card = FactoryGirl.create(:card, original_text: "qwerty")
    @data = card.look_for_similar("qwerut")
    expect(@data.first[0]).to eq("qwerty")
  end
end
