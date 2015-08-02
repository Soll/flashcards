require "rails_helper"

describe HomeController do
	before (:each) do
    @card = FactoryGirl.create(:card)
  end

  it "incorrect translation shows proper page" do
    #card = FactoryGirl.create(:card)
    visit root_path
    fill_in "home_cards_review_text", with: "das is fantastish"
    click_button "Проверить"
    expect(@card.check_translation("das ist fantastish")).to be false
    get :check_translation_path
    response.should have_selector("h2", :content => "Перевод неверен")
    #expect(page).to have_content "Перевод неверен"
  end

  it "correct translation shows proper page" do
    #card = FactoryGirl.create(:card)
    visit root_path
    fill_in "home_cards_review_text", with: "das"
    click_button "Проверить"
    expect(@card.check_translation("das")).to be true
    expect(page).to have_content "Список карточек"
  end


  it "opens new card page after click on link" do
    visit new_card_path
    expect(page).to have_content "Новая карточка"
  end
end
