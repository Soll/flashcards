class HomeController < ApplicationController
  def index
    c = Card.all.created_before(Time.now).count
    @card = Card.created_before(Time.now).offset(rand(c)).first
  end

  def check_translation
    if params[:home][:cards][:original_text].mb_chars.downcase == params[:home][:cards][:review_text].mb_chars.downcase
      @card = Card.find(params[:home][:cards][:id])
      set_new_review_date(@card)
      redirect_to cards_path
    else
      render "check_translation"
    end
  end

  def set_new_review_date(c)
    c.update_column(:review_date, 3.days.from_now)
  end
end
