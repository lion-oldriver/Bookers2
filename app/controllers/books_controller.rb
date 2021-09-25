class BooksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @book = Book.new
    if params[:sort] == 'latest'
      @books = Book.latest
    elsif params[:sort] == 'rated'
      @books = Book.rated
    elsif params[:sort] == 'favorite'
      @books = Book.last_week
    elsif params[:sort] == 'views'
      @books = Book.views
    else
      @books = Book.all
    end
    @chartbooks = Book.all
    @books_by_day = @chartbooks.group_by_day(:created_at, last: 7).size
    @chartlabels = @books_by_day.map(&:first).to_json.html_safe
    @chartdatas = @books_by_day.map(&:second)
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @book_comment = BookComment.new
    @user = User.find(@book.user_id)
    impressionist(@book, nil, unique: [:ip_address])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), flash: { notice: "You have created book successfully." }
    else
      session[:error_message] = @book.errors.full_messages
      redirect_to books_path
    end
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
      redirect_to book_path(params[:id]), flash: { notice: "You have updated book successfully." }
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
    params.require(:book).permit(:title, :body, :rate, :category)
  end
end
