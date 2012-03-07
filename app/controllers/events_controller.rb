class EventsController < ApplicationController

  def show
    @event = current_user.events.find(params[:id])
    
    facebook_service = current_user.services.find_by_provider_id(Provider.find_by_name('facebook').id)
    if facebook_service # and showing the uncategorized event?
      api = Koala::Facebook::API.new(facebook_service.oauth_token)
      # TODO: go over every album, in each album download every photo and add it to the uncategorized event
    end
  end
  
end
