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
            :oauth_token_secret => auth['credentials']['secret'],
          )
      redirect_to photos_path, :notice => t('flash_new_service', :provider => provider.displayed_name)
  end

  def destroy
    @service = current_user.services.find(params[:id])
    @service.destroy if @service
      redirect_to photos_path, :notice => t('flash_service_deleted', :provider => provider.displayed_name)
  end


end
