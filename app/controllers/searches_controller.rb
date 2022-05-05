class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @range = params[:range]
    @search = params[:search]
    

    if @range == "User"
      @records = User.looks(@search, @word)
    elsif @range == "Book"
      @records = Book.looks(@search, @word)
    elsif @range == "Tag"
      @records = Tag.looks(@search, @word)
    end
  end
end