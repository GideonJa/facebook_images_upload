require 'open-uri'

# rake resque:work QUEUE='*'
class FacebookImporter
  @queue = :import_queue
  
  def self.perform(service_id)
    service = Service.find(service_id)
    user = User.find(service.user_id)
    api = Koala::Facebook::API.new(service.oauth_token)

    total_photos = 0
    api.get_connections('me', 'albums').each do |album|
      api.get_connections(album['id'], 'photos').each do |photo|
        unless user.photos.find_by_provider_uid(photo['id'])
          total_photos += 1
        end
      end
    end
    
    service.update_attributes :import_total_photos => total_photos, :import_num_photos => 0
    if total_photos > 0
      num_photos = 0
      api.get_connections('me', 'albums').each do |album|
        api.get_connections(album['id'], 'photos').each do |photo|
          unless user.photos.find_by_provider_uid(photo['id'])
            io = open(photo['source'])
            def io.original_filename; File.basename(base_uri.path); end
            user.photos.create(
              :event_id => user.events.first.id,
              :service_id => service.id,
              :provider_uid => photo['id'],
              :metadata => {'album' => album, 'photo' => photo},
              :file => io )
            num_photos += 1
            service.update_attribute :import_num_photos, num_photos
          end
        end
      end
      # TODO: change copy and link information:
      api.put_wall_post("I've just imported photos into PixelMate!", {:name => "Example", :link => "http://www.example.com"})    
    end
    
    service.update_attribute :import_ended_at, Time.now
  end
  
end