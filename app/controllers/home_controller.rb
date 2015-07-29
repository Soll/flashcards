class HomeController < ApplicationController
  def index
    @card = Card.created_before(Time.now).random_record
  end
  
  def check_translation
    @card = Card.find(params[:home][:cards][:id])
    if @card.check_translation(params[:home][:cards][:review_text])
      redirect_to cards_path
    else
      render "check_translation"
    end  
  end
end
