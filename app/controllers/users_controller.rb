class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "新規ユーザー作成に成功しました。"
      redirect_to "#"
    else
      render :new
    end
  end
  
end
