class FacebookFriendsUpdater
  @queue = :friends_updater_queue

  def self.perform(service_id)
    service = Service.find(service_id)
    user = User.find(service.user_id)
    api = Koala::Facebook::API.new(service.oauth_token)
    
    x = api.get_connections('me', 'friends')
    metadata = service.metadata
    metadata['friends'] = x
    service.update_attribute :metadata, metadata
  end
end
