class SessionsController < ApplicationController
  def create
    # メールアドレスでユーザーを検索
    user = User.find_by(name: session_params[:name])
    # パスワードの一致を検証
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: 'ログイン成功'
    else
      render :new
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path
  end
  
  private
  
  def session_params
    params.require(:session).permit(:name, :password)
  end
end
