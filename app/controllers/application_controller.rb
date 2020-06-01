class ApplicationController < ActionController::Base
  include Pundit
  # 捕获无权限异常
  rescue_from Pundit::NotAuthorizedError do
    flash[:error] = "你没有权限哦。请把ID为1的用户 name修改成liym"
    redirect_to library_books_path
  end


end
