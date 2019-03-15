class CategoriesController < ApplicationController

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was successfully saved!"
      redirect_to categories_path
    else
      flash[:danger] = "Category was NOT successfully saved!"
      render 'new'
    end
  end

  def update

  end


  def show

  end

  private
    # def set_user
    #   @user = User.find(params[:id])
    # end

    def category_params
      params.require(:category).permit(:name)
    end

end