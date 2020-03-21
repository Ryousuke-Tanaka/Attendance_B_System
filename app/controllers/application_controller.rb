class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # paramsハッシュからユーザーを取得します。
  def set_user
    @user = User.find(params[:id])
  end
end
