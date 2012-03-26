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
      redirect_to import_path(:provider => provider.name)
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

    if @provider.name == 'facebook'
      Resque.enqueue(FacebookImporter, @service.id)
    end

    redirect_to @uncategorized_event, :notice => t('flash_notice_photos_imported', :count => 1)
  end

end
