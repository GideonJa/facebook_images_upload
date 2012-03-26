require 'open-uri'

class FacebookImporter
  @queue = :import_queue
  
  def self.perform(service_id)
    service = Service.find(service_id)
    service.update_attribute :import_started_at, Time.now
    user = User.find(service.user_id)
    api = Koala::Facebook::API.new(service.oauth_token)
    api.get_connections('me', 'albums').each do |album|
      api.get_connections(album['id'], 'photos').each do |photo|
        unless user.photos.find_by_provider_uid(photo['id'])
          user.photos.create(
            :event_id => user.events.first.id,
            :service_id => service.id,
            :provider_uid => photo['id'],
            :metadata => {'album' => album, 'photo' => photo},
            :file => open(photo['source']) )
        end
      end
    end    
    service.update_attribute :import_ended_at, Time.now
  end
  
end