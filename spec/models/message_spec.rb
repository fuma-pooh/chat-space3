require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    context 'can save' do
    # この中にメッセージを保存できる場合のテストを記述
      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid
      end

      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
      end

      it 'is valid with content and image' do
      # 引数なしーメッセージと画像を持ったインスタンスを生成することができます
        expect(build(:message)).to be_valid
      end
    end
    # メッセージを保存できる場合
    # メッセージがあれば保存できる
    # 画像があれば保存できる
    # メッセージと画像があれば保存できる

    # buildメソッドは、カラム名: 値の形で引数を渡すことによって、ファクトリーで定義されたデフォルトの値を上書きすることができます



    context 'can not save' do
    # この中にメッセージを保存できない場合のテストを記述
      it 'is invalid without content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end


# メッセージを保存できない場合
# メッセージも画像も無いと保存できない
# group_idが無いと保存できない
# user_idが無いと保存できない 