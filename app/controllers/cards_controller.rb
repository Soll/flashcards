class CardsController < ApplicationController
  before_action :set_card, only: [:edit, :update, :show, :destroy]
  
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create(card_params)
    if @card.errors.empty?
  		redirect_to @card
  	else
      render "new"
  	end
  end

  def show
  end

  def edit
  end

  def update
    @card.update_attributes(card_params)
    if @card.errors.empty?
  	  redirect_to @card
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private
  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end
end
