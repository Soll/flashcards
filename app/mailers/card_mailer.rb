class CardMailer < ApplicationMailer
  default from: "new-cards@flashcards.com"

  def send_expired_cards(email)
    @email = email
    @url = "http://flashcards.com"

    @cards = Card.created_before(Time.now)
    mail(to: @email, subject: "Простроченные карточки на проверку от сайта Flashcards.com")    
  end
end
