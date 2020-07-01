class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to boop, #{@user.username}!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user = User.update(user_params)
      flash[:notice] = "Account was successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil if @user == current_user
      flash[:notice] = "Your account and all associated articles were successfully deleted."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own profile."
      redirect_to @user
    end
  end
end
