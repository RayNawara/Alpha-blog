class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
  @article = Article.new
  end

  def edit
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully saved!"
      redirect_to article_path(@article)
    else
      flash[:danger] = "Article was NOT successfully saved!"
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      flash[:danger] = "Article was NOT successfully updated!"
      render 'edit'
    end
  end


  def show
  end

  def destroy
    if @article.destroy
      flash[:warning] = "Article was successfully deleted!"
      redirect_to articles_path
    else
      flash[:danger] = "Article was NOT successfully deleted!"
      render 'destroy'
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def require_user
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to root_path
      end
    end

    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to root_path
      end
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end