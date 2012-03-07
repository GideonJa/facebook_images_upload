Rails.application.config.middleware.use OmniAuth::Builder do
  # Provider.all.each do |p|
  #   provider p.name.to_sym, p.consumer_key, p.consumer_secret
  # end
  facebook = Provider.find_by_name('facebook')
  provider :facebook, facebook.consumer_key, facebook.consumer_secret, {:client_options => {:ssl => {:ca_file => "/etc/ssl/certs/ca-bundle.crt"}}, :scope => 'user_photos'}

end