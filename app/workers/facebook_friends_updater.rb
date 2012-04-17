class FacebookFriendsUpdater
  def self.perform(service_id)
    service = Service.find(service_id)
    user = User.find(service.user_id)
    api = Koala::Facebook::API.new(service.oauth_token)
    
    
  end
end
