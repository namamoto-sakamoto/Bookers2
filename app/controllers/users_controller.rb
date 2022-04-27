class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def top
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path
    else
      render :books_path
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user.id)) unless @user == current_user
  end
end
