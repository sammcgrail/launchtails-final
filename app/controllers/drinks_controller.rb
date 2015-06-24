class DrinksController < ApplicationController
  def new
    @drink = Drink.new
    @categories = Category.all.collect
  end

  def create
    unless drink_params[:category].nil?
      category = Category.find(drink_params[:category])
    end
    @categories = Category.all.collect
    @drink = Drink.new(title: drink_params[:title], description: drink_params[:description], featured: drink_params[:featured], category: category, alcohol_level: drink_params[:alcohol_level])
    if @drink.save
      flash[:notice] = 'Drink added.'
      redirect_to '/drinks'
    else
      render :new
    end
  end


  def show
    @drink = Drink.find(params[:id])
    @category = Category.find(@drink.category_id).name
  end

  def update
    @drink = Drink.find(params[:id])
    @drink.update_attributes(params[:drink])
    redirect_to @drink
  end

  def destroy
    # @drink = Drink.find(params[:id])
    # @drink.destroy
    Drink.destroy(params[:id])
    # redirect_to '/drinks'
    flash[:notice] = "Drink deleted"
    redirect_to drinks_path
  end

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      # @drinks = Drink.where(category_id: params[:category_id])  better below
      @drinks = @category.drinks
    else
      @drinks = Drink.all
    end
  end

  protected
  def drink_params
    params.require(:drink).permit(:title, :description, :featured, :category, :alcohol_level)
  end
end
