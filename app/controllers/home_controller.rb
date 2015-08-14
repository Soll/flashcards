class HomeController < ApplicationController
  skip_before_filter :require_login, only: [:index, :check_translation]

  def index
    if (@card = Card.from_active_category.created_before(Time.now).random_record) == nil
      @card = Card.created_before(Time.now).random_record
    end
  end

  def check_translation
    @card = Card.find(params[:home][:cards][:id])
    if @card.check_translation(params[:home][:cards][:review_text])
      @card.reset_bad_attempts
      @card.set_new_review_date
      @card.up_level
      render "correct_translation"
    else
      @card.inc_bad_attempts
      if @card.bad_attempts == 3
        @card.reset_bad_attempts
        @card.down_level
        @card.set_new_review_date
      end
      render "error_translation"
    end
  end
end
