class GroupsController < ApplicationController

  def index
  end

  def new
    @group = Group.new
    # form_withで使用するための変数
    @group.users << current_user
    # 配列に要素を追加するためのもの
  end

  def create
    # new.html.hamlで指定された「name」キーに「グループ名」が、「user_ids」キーに「所属ユーザーのidの配列」の値が送信されている。
    @group = Group.new(group_params)
    # 保存がうまくいったかどうかで処理を分岐
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
    # 配列に対して保存を許可したい場合,キーの名称と関連づけてバリューに「[]」と記述
  end


end
