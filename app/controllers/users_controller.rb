class UsersController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      redirect_to books_path
    end
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @book = Book.find(params[:id])
    if @user.id == current_user.id
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(params[:id]), flash: {notice:"You have updated user successfully."}
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

end
