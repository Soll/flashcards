require "rails_helper"

describe HomeController do
  let!(:card) { FactoryGirl.create :card }

  it "incorrect translation shows proper page" do
    visit root_path
    fill_in "home_cards_review_text", with: "das is fantastish"
    click_button "Проверить"
    expect(card.check_translation("das ist fantastish")).to be false
    expect(page).to have_content "Перевод неверен"
  end

  it "correct translation shows proper page" do
    visit root_path
    fill_in "home_cards_review_text", with: "das"
    click_button "Проверить"
    expect(card.check_translation("das")).to be true
    expect(page).to have_content "Правильный перевод"
  end

  it "opens user info after correct login" do
    visit login_path
    fill_in "user_email", with: "user1@mail.ru"
    fill_in "user_password", with: "222222"
    click_button "submit"
    expect(page).to have_content "Информация о пользователе"
  end

  it "shows login page again after incorrect login" do
    visit login_path
    fill_in "user_email", with: "user1@mail.ru"
    fill_in "user_password", with: "111111"
    click_button "submit"
    expect(page).to have_content "Вход для зарегистрированных пользователей"
  end

  it "shows root page again after logout" do
    visit login_path
    fill_in "user_email", with: "user1@mail.ru"
    fill_in "user_password", with: "222222"
    click_button "submit"
    click_link "[ВЫХОД]"
    expect(page).to have_content "Первый в мире удобный менеджер флеш-карточек"
  end

  it "shows card list of current user" do
    visit login_path
    fill_in "user_email", with: "user1@mail.ru"
    fill_in "user_password", with: "222222"
    click_button "submit"
    click_link "Список карточек"
    expect(page).to have_content "Список карточек"
  end
end
