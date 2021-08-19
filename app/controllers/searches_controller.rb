class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = seach_for(@model, @content, @method)
  end

  private
  def seach_for(model, cintent, method)
    if model == 'User'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'forward_match'
        User.where('name LIKE ?', content+'%' )
      elsif method == 'rear_match'
        User.where('name LIKE ?', '%'+content)
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'Book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'forward_match'
        Book.where('title LIKE ?', content+'%' )
      elsif method == 'rear_match'
        Book.where('title LIKE ?', '%'+content)
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end
