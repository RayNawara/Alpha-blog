class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def edit
  end
  
  def create
    # render plain: params[:article].inspect
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      flash[:danger] = "User was NOT successfully saved!"
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was successfully updated!"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Your account was NOT successfully updated!"
      render 'edit'
    end
  end
  

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    if @user.destroy
      flash[:warning] = "User was successfully deleted!"
      redirect_to users_path
    else
      flash[:danger] = "User was NOT successfully deleted!"
      render 'destroy'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end