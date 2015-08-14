Rails.application.config.sorcery.submodules = [:external]
Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:facebook, :google, :github]
  
  config.facebook.key = Rails.application.secrets.facebook_key
  config.facebook.secret = Rails.application.secrets.facebook_secret
  config.facebook.callback_url = "https://agile-plateau-3822.herokuapp.com/oauth/callback?provider=facebook"
  config.facebook.user_info_mapping = {:email => "email", :name => "name", :username => "username" } #etc
  config.facebook.scope = "email,user_hometown,user_likes" #etc
  
  config.google.key = Rails.application.secrets.google_key
  config.google.secret = Rails.application.secrets.google_secret
  config.google.callback_url = "https://agile-plateau-3822.herokuapp.com/oauth/callback?provider=google"
  config.google.user_info_mapping = { email: "email" }

  config.github.key = "b4969aec56e741dc0d36"
  config.github.secret = "2fa38968aa89035a43c8a2796b00cd6d4f4fc8bd"
  config.github.callback_url = "https://agile-plateau-3822.herokuapp.com/oauth/callback?provider=github"
  config.github.user_info_mapping = { email: "email"}
    
  config.user_config do |user|
    user.username_attribute_names = :email
    user.authentications_class = Authentication
  end
  config.user_class = "User"
end
