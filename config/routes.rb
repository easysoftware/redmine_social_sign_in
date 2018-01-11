get 'social_sign_in/:provider/callback', to: 'redmine_social_sign_in_callbacks#social_sign_in_callback'
get 'social_sign_in/failure', to: 'redmine_social_sign_in_callbacks#failure'