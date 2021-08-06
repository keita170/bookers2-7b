class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.order(:created_at)

    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week

    @two = @books.created_2days
    @three = @books.created_3days
    @four = @books.created_4days
    @five = @books.created_5days
    @six = @books.created_6days

  end


  def search
    @user = User.find(params[:user_id])
    @book = Book.new
    @books = @user.books.order(:created_at)

    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      @search_book = @books.where(['created_at LIKE ?',"#{params[:created_at]}%"]).count
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
