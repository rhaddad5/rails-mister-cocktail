class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @cocktails = policy_scope(Cocktail).order(created_at: :desc)
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
    authorize @cocktail
  end

  def new
    @cocktail = Cocktail.new
    @user = current_user
    authorize @cocktail
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    authorize @cocktail
    @cocktail.user_id = current_user[:id]
    @cocktail.save
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :user)
  end
end
