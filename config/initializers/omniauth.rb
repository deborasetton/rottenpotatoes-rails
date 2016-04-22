Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "APP_KEY", "APP_SECRET"
end

def OmniAuth.login_path(provider)
  "/auth/#{provider}"
end
