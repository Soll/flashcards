class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index, :check_translation, :send_letters]

  def send_letters
    @users = User.all
    #@cards = Card.created_before(Time.now)
    @users.each do |user|
      CardMailer.send_expired_cards(user.email).deliver_now
    end
    redirect_to root_path
  end

  def index
    if (@card = Card.from_active_category.created_before(Time.now).random_record) == nil
      @card = Card.created_before(Time.now).random_record
    end
  end

  def check_translation
    @card = Card.find(params[:home][:cards][:id])
    if @card.check_translation(params[:home][:cards][:review_text])
      @card.review_text = params[:home][:cards][:review_text]
      render "correct_translation"
    else
      render "error_translation"
    end
  end
end
