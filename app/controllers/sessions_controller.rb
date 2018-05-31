class SessionsController < ApplicationController
  def new
    
    # ログイン済みならroot_pathにリダイレクトさせる
    redirect_to root_path if logged_in?
    
    # パラメータに「?launcher=true」が指定されていたら
    # PWAとしてアクセスしてきたと判断する
    @pwa = true if params['launcher'] == 'true'
  end
  
  def create
    # メールアドレスでユーザーを検索
    user = User.find_by(name: session_params[:name])
    # パスワードの一致を検証
    if user && user.authenticate(session_params[:password])
      
      # SessionとCookieにuser.idを保存
      session[:user_id] = user.id
      cookies[:user_id] = user.id
      
      respond_to do |format|
        # 「remote:true」が指定されてないフォームからログインした場合は
        # root_pathにリダイレクトさせる
        format.html { redirect_to root_path }
        
        # 「remote:true」が指定されてるフォームからログインした場合は
        # 「create.js.erb」でtokenをLocalStorageに保存する
        format.js { @token = user.token }
      end
    
    else
      render :new
    end
  end
  
  def destroy
    
    # SessionとCookieを削除
    reset_session
    cookies.delete :user_id
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {}
    end
  
  end
  
  private
  
  def session_params
    params.require(:session).permit(:name, :password)
  end
end
