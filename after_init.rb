RedmineExtensions::Reloader.to_prepare do

  require 'redmine_social_sign_in/hooks'

end

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :google_oauth2, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['google_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['google_app_secret']
  }, scope:                       'email,profile', path_prefix: '/social_sign_in'

  provider :facebook, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['facebook_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['facebook_app_secret']
  }, scope:                  'email,public_profile', path_prefix: '/social_sign_in'

  provider :linkedin, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['linkedin_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['linkedin_app_secret']
  }, path_prefix:            '/social_sign_in'

  provider :twitter, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['twitter_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['twitter_app_secret']
  }, path_prefix:           '/social_sign_in'

  provider :qq_connect, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['qq_connect_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['qq_connect_app_secret']
  }, scope:                    'get_user_info', path_prefix: '/social_sign_in'

  provider :wechat, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['wechat_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['wechat_app_secret']
  }, scope:                'snsapi_userinfo', path_prefix: '/social_sign_in'

end

