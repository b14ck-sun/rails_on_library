class BooksController < ApplicationController

  before_action :authenticate_user!
  def index
    @books = Book.all
  end

  def show
    if Book.exists?(params[:id])
      @book = Book.find(params[:id])
      @borrows = Borrow.where(book:@book, state:"borrowed")
    else
      render :template => "books/notfound"
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(title:book_params[:title], writer:book_params[:writer], cost:book_params[:cost], limit:book_params[:limit], user:current_user)
    if @book.save
      redirect_to @book
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(title:book_params[:title], writer:book_params[:writer], cost:book_params[:cost])
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to root_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :writer, :limit, :cost)
    end

end
