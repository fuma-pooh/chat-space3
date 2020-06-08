module ControllerMacros
  def login(user)
    # loginメソッドを定義します
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end