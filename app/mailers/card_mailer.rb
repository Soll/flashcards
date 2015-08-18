class CardMailer < ApplicationMailer
  default from: "new-cards@flashcards.com"

  def send_expired_cards(user)
    @user = user
    @url = "http://flashcards.com"
    mail(to: @user.email, subject: "Простроченные карточки на проверку от сайта Flashcards.com")
  end
end
