require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do

    context 'log in' do
    # ログインしている場合
    # アクション内で定義しているインスタンス変数があるか
    # 該当するビューが描画されているか
      before do
      # beforeブロックの内部に記述された処理は、各exampleが実行される直前に、毎回実行されます。beforeブロックに共通の処理をまとめることで、コードの量が減り、読みやすいテストを書くことができます。
        login user
        get :index, params: { group_id: group.id }
      end

      it 'assigns @message' do
      # @messageはMessage.newで定義された新しいMessageクラスのインスタンスです
        expect(assigns(:message)).to be_a_new(Message)
      # be_a_newマッチャを利用することで、 対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうか確かめることができます
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
    # ログインしていない場合
    # 意図したビューにリダイレクトできているか
      before do
        get :index, params: { group_id: group.id }
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'log in' do
      # ログインしているかつ、保存に成功した場合
      # メッセージの保存はできたのか
      # 意図した画面に遷移しているか
      before do
        login user
      end

      context 'can save' do
      # 保存に成功した場合
        subject {
          post :create,
          params: params
        }

        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'can not save' do
        # ログインしているが、保存に失敗した場合
        # メッセージの保存は行われなかったか
        # 意図したビューが描画されているか
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do
    # ログインしていない場合
    # 意図した画面にリダイレクトできているか
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
