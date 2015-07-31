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

  it "opens new card page after click on link" do
    visit new_card_path
    expect(page).to have_content "Новая карточка"
  end

  it "must change date after correct translation" do
    card = FactoryGirl.create(:card)
    old_date = card.review_date
    card.set_new_review_date
    expect(card.review_date > old_date).to be true
  end

  it "incorrect translation shows proper page" do
    card = FactoryGirl.create(:card)
    visit root_path
    fill_in "home_cards_review_text", with: "das is fantastish"
    click_button "Проверить"
    expect(card.check_translation("das ist fantastish")).to be false
    expect(page).to have_content "Перевод неверен"
  end

  it "correct translation shows proper page" do
    card = FactoryGirl.create(:card)
    visit root_path
    fill_in "home_cards_review_text", with: "das"
    click_button "Проверить"
    expect(card.check_translation("das")).to be true
    expect(page).to have_content "Список карточек"
  end

end