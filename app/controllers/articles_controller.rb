class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    # renders the article hash from params when form is submitted but it won't save to the db
    # render plain: params[:article]

    # whitelisting data values associated with attributes from params[:article]
    @article = Article.new(article_params)
    @article.user = current_user

    # renders submitted article details by calling inspect method on the article object
    # render plain: @article.inspect

    if @article.save
      flash[:notice] = "Article was created successfully."
      # normal redirect to show page
      # redirect_to article_path(@article)

      # shortened redirect to show page
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    # byebug
      # debug in terminal and we can find what the params are when clicking 'update' on the form 
      # entering in 'params' in terminal

    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article was deleted successfully."
      redirect_to articles_path
    else
      flash[:alert] = "Article can't be deleted."
      redirect_to articles_path
    end
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article."
      redirect_to @article
    end
  end
end
