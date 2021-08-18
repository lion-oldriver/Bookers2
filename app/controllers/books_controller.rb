class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), flash: {notice:"You have created book successfully."}
    else
      session[:error_message] = @book.errors.full_messages
      redirect_to books_path
    end
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @book_comment = BookComment.new
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    if @user.id == current_user.id
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(params[:id]), flash: {notice:"You have updated book successfully."}
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

end
