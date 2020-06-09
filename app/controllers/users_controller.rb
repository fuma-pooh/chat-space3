class UsersController < ApplicationController

  def index
    return nil if params[:keyword] == ""
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    binding.pry
    params.require(:user).permit(:name, :email)
  end
end

  # params :keyword に値が入っていればそのまま処理は続けられ、
  # 空だった場合はそこで処理が終わります

  # 検索処理の内容は、whereメソッドを使用し、入力された値を含むかつ、
  # ログインしているユーザーのidは除外するという条件で取得しています