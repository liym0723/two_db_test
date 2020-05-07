class Library::BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]


  def index
    @books = initialize_grid( Library::Book.includes(:user),order: 'id')
   # @books = Library::Book.all
  end

  def new
    @book = Library::Book.new
  end

  def create
    book = Library::Book.new book_params
    if book.valid?
      book.save(validate: false)
      redirect_to library_books_path,notice: "success"
    else
      render :new
    end

  end

  def show
  end

  def edit
  end

  def update
    @book.attributes = book_params # 修改当前jimu_user 的值
    if @book.valid?
      @book.save(validate: false)
      redirect_to library_books_path,notice: "success"
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to library_books_path,notice: "success"
  end

  private

  def book_params
    params.require(:library_book).permit(:name,:user_id)
  end

  def set_book
    @book = Library::Book.where(id: params[:id]).first
  end
end
