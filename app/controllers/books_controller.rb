class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user, only: [:edit]
  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
  end

  def index
  	@books = Book.all
    @book = Book.new
    @user = current_user #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
    @user = current_user
    @books = Book.all
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	if @book.save!#入力されたデータをdbに保存する。
  		redirect_to book_path(@book.id), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      flash[:notice] = "error"
  		render :index
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book.id), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      flash[:notice] = "error"
  		render :edit
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
