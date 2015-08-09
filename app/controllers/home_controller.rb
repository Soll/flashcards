class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index, :check_translation]
  
  def index
    @card = Card.created_before(Time.now).random_record
  end
  
  def check_translation
    @card = Card.find(params[:home][:cards][:id])
    if @card.check_translation(params[:home][:cards][:review_text])
      @card.set_new_review_date
      render "correct_translation"
    else
      render "error_translation"
    end  
  end
end
