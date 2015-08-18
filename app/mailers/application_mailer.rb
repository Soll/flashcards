class ApplicationMailer < ActionMailer::Base
  default from: "new-cards@flashcards.com"
  layout 'mailer'
end
