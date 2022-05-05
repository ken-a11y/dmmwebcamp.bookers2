class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end
  
  def index
    @books = Book.all.order(params[:sort])
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(',')
    if @book.save
      @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
  end
  
  def update
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book)  
    else
      render :edit
    end
  end
  
  def destroy
    @book.destroy
    redirect_to '/books' 
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end
  
  def correct_book_user
    @book = Book.find(params[:id])
    if @book.user != current_user
       redirect_to books_path
    end
  end
end