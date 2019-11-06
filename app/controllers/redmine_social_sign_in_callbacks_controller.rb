class RedmineSocialSignInCallbacksController < AccountController

  skip_before_action :verify_authenticity_token, only: [:social_sign_in_callback, :failure]

  def social_sign_in_callback
    auth = request.env['omniauth.auth']
    user = User.joins(:email_addresses).where(email_addresses: { address: auth.info.email }).first if auth.info && !auth.info.email.blank?

    if user
      if user.active?
        successful_authentication(user)
      else
        handle_inactive_user(user)
      end
    else
      if !Setting.self_registration?
        flash[:warning] = l(:notice_sso_need_login)

        redirect_to(home_url)
        return
      end

      user           = User.new
      user.mail      = get_attribute(auth, :email)
      user.firstname = get_attribute(auth, :first_name)
      user.lastname  = get_attribute(auth, :last_name)
      user.random_password
      user.register

      case Setting.self_registration
      when '1'
        register_by_email_activation(user) do
          onthefly_creation_failed(user)
        end
      when '3'
        register_automatically(user) do
          onthefly_creation_failed(user)
        end
      else
        register_manually_by_administrator(user) do
          onthefly_creation_failed(user)
        end
      end
    end
  end

  def failure
    flash[:warning] = params[:message]

    redirect_back_or_default home_url
  end

  protected

  def get_attribute(auth, attr)
    return nil if auth.nil?

    val = get_raw_attribute(auth.info, attr) if auth.info
    val ||= get_raw_attribute(auth.extra, attr) if auth.extra
    val ||= get_raw_attribute(auth.extra.raw_info, attr) if auth.extra.raw_info
    val ||= get_raw_attribute(auth, attr)
    val.presence
  end

  def get_raw_attribute(obj, attr)
    return nil if obj.nil?

    val = obj.try(attr)
    val.presence
  end

end
