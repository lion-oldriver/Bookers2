class UsersController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @today_books = @books.created_today
    @yesterday_books = @books.created_yesterday
    @day_ratio = @today_books.count / @yesterday_books.count.to_f
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week
    @week_ratio = @this_week_books.count / @last_week_books.count.to_f
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を入力してください"
    else
      created_at = params[:created_at]
      @search_book = @books.where('created_at LIKE ?', "#{created_at}%").count
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(params[:id]), flash: { notice: "You have updated user successfully." }
    else
      render "edit"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
