Redmine::Plugin.register :redmine_social_sign_in do
  name 'Social Sign In'
  author 'Easy Software Ltd'
  description 'sign in through social network like Google, Facebook and others '
  version '1.0.3'
  url 'https://www.easysoftware.com'

  settings partial: 'settings/redmine_social_sign_in',
           default: {
               'google_enabled'        => '0',
               'google_app_id'         => '',
               'google_app_secret'     => '',
               'facebook_enabled'      => '0',
               'facebook_app_id'       => '',
               'facebook_app_secret'   => '',
               'linkedin_enabled'      => '0',
               'linkedin_app_id'       => '',
               'linkedin_app_secret'   => '',
               'twitter_enabled'       => '0',
               'twitter_app_id'        => '',
               'twitter_app_secret'    => '',
               'qq_connect_enabled'    => '0',
               'qq_connect_app_id'     => '',
               'qq_connect_app_secret' => '',
               'wechat_enabled'        => '0',
               'wechat_app_id'         => '',
               'wechat_app_secret'     => ''
           }
end

if Redmine::Plugin.registered_plugins[:easy_extensions].nil?
  require_relative 'after_init'
end
