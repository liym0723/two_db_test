class GemTestsController < ApplicationController

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.valid?
    render :new
  end

  def edit
    @user = User.find_by(id: 7)
  end

  def update
    @user = User.find_by(id: 7)
    @user.avatar = nil
    @user.save
    render :new
  end


  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
