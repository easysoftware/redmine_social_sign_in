module RedmineSocialSignIn
  class Hooks < Redmine::Hook::ViewListener

    render_on :view_account_login_bottom, partial: 'redmine_social_sign_in/view_account_login_bottom'

  end
end
