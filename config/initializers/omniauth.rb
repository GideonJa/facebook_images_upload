Rails.application.config.middleware.use OmniAuth::Builder do
  Provider.all.each do |p|
    provider p.name.to_sym, p.consumer_key, p.consumer_secret
  end
end