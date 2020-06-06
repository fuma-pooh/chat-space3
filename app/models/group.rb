class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages
  validates :name, presence: true, uniqueness: true

  def show_last_message
    if (last_message = messages.last).present?
      if last_message.content?
        last_message.content
      else
        '画像が投稿されています'
      end
    else
      'まだメッセージはありません。'
    end
  end
  # サイドバーのグループ部分に最新のメッセージが表示されるようにしている
  # show_last_messageメソッドでは、メッセージが投稿されている場合、されていない場合で処理を分ける
  # if (last_message = messages.last).present?」と記述することで、最新のメッセージを変数last_messageに代入しつつ、メッセージが投稿されているかどうかで場合分けする
end
