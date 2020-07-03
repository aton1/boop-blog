class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = "Boop article was created successfully."
      redirect_to @article
    else
      render "new"
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Boop article was updated successfully."
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Boop article was deleted successfully."
      redirect_to articles_path
    else
      flash[:alert] = "Boop article can't be deleted."
      redirect_to articles_path
    end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own boops."
      redirect_to @article
    end
  end
end
