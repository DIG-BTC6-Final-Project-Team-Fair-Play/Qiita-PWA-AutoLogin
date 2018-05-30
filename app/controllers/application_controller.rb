class ApplicationController < ActionController::Base
  # メソッドをヘルパーメソッドとして登録
  helper_method :logged_in?, :current_user

# ログインの有無を得る
  def logged_in?
    !!session[:user_id]
  end

# ログインしているユーザーオブジェクトを得る
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
end
