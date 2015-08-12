class CategoriesController < ApplicationController
  skip_before_filter :require_login
  before_action :set_category, only: [:edit, :destroy, :update]
  before_action :search_active_category, on: [:change_current_category]

  def search_active_category
    @active_category = Category.get_active_category
  end

  def change_current_category
    if @active_category
      @active_category.set_category_inactive          
    end
    @new_cat = Category.find(params[:category][:id])
    @new_cat.set_category_active
    redirect_to categories_path
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.errors.empty?
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @category.update_attributes(category_params)
    if @category.errors.empty?
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:id, :name, :active)
    end
end
