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

    unless @service.import_started_at
      @service.update_attribute :import_started_at, Time.now
      if @provider.name == 'facebook'
        Resque.enqueue(FacebookImporter, @service.id) 
      end
    end

    redirect_to @uncategorized_event
  end

  def import_status
    @service = current_user.services.find(params[:service_id])
    respond_to do |format|
      format.js
    end
  end

  def chat
    @provider = Provider.find_by_name(params[:provider])
    @service = Service.find_by_provider_id_and_uid(@provider.id, params[:uid])
    if @service
      render :text => "chat with user=#{@service.user.name}"
    else
      @service = current_user.services.find_by_provider_id(@provider.id)
      redirect_to service_invite_path(:service_id => @service.id, :uid => params[:uid], :name => params[:name])
    end
  end
  
  def invite
    @service = current_user.services.find(params[:service_id])
    @invited_service = Service.find_by_provider_id_and_uid(@service.provider.id, params[:uid])
    
    if @invited_service
      redirect_to chat_path(:provider => @service.provider.name, :uid => params[:uid])
      return
    end
  end
  
  def create_invitation
    puts "service_id = #{params[:service_id]}"
    @service = current_user.services.find(params[:service_id])
    @invited_service = Service.find_by_provider_id_and_uid(@service.provider.id, params[:uid])
    
    if @invited_service
      redirect_to chat_path(:provider => @service.provider.name, :uid => params[:uid])
      return
    end
    
    if @service
      api = Koala::Facebook::API.new(@service.oauth_token)
      # TODO: change link
      api.put_wall_post(params[:message], {:name => "Example", :link => "http://www.example.com"}, params[:uid])
    end
  end
  
end
