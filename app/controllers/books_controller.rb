class BooksController < ApplicationController
   before_action :correct_book_user, only: [:edit]
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def create
    @user = current_user
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)  
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books' 
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_book_user
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
       redirect_to books_path
    end
  end
end