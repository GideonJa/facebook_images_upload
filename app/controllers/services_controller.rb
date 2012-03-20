require 'open-uri'

class ServicesController < ApplicationController

  protect_from_forgery :except => :create

  def create
      auth = request.env["omniauth.auth"]
      provider = Provider.find_by_name(auth["provider"])
      @service = current_user.services.find_by_provider_id_and_uid(provider.id, auth["uid"]) || 
          current_user.services.create(
            :provider_id => provider.id,
            :uid => auth['uid'],
            :oauth_token => auth['credentials']['token'],
            :oauth_token_secret => auth['credentials']['secret'])
      redirect_to event_path(current_user.events.first.id)
  end

  def destroy
    @service = current_user.services.find(params[:id])
    provider = @service.provider
    @service.destroy if @service
    redirect_to event_path(current_user.events.first.id)
  end
  
  def import
    @provider = Provider.find_by_name(params[:provider])
    @service = current_user.services.find_by_provider_id(@provider.id)
    @uncategorized_event = current_user.events.first #TODO: find uncategorized

    photos_added = 0
    if @provider.name == 'facebook'
      api = Koala::Facebook::API.new(@service.oauth_token)
      api.get_connections('me', 'albums').each do |album|
        api.get_connections(album['id'], 'photos').each do |photo|
          unless current_user.photos.find_by_service_id_and_provider_uid(@service.id, photo['id'])
            current_user.photos.create(
              :event_id => @uncategorized_event.id,
              :service_id => @service.id,
              :provider_uid => photo['id'],
              :metadata => {'album' => album, 'photo' => photo},
              :file => open(photo['source']) )
            photos_added += 1
          end
        end
      end
    end

    redirect_to @uncategorized_event, :notice => t('flash_notice_photos_imported', :count => photos_added)
  end

end
