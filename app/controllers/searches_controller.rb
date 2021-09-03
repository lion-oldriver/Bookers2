class SearchesController < ApplicationController
  def search
    @user = User.find(current_user.id)
    @book = Book.new
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    @records = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'forward_match'
        User.where('name LIKE ?', content + '%')
      elsif method == 'rear_match'
        User.where('name LIKE ?', '%' + content)
      else
        User.where('name LIKE ?', '%' + content + '%')
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'forward_match'
        Book.where('title LIKE ?', content + '%')
      elsif method == 'rear_match'
        Book.where('title LIKE ?', '%' + content)
      else
        Book.where('title LIKE ?', '%' + content + '%')
      end
    elsif model == 'category'
      if method == 'perfect'
        Book.where(category: content)
      elsif method == 'forward_match'
        Book.where('category LIKE ?', content + '%')
      elsif method == 'rear_match'
        Book.where('category LIKE ?', '%' + content)
      else
        Book.where('category LIKE ?', '%' + content + '%')
      end
    end
  end
end
