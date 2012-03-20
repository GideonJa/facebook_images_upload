class EventsController < ApplicationController

  def show
    @event = current_user.events.find(params[:id])
    @photos = @event.photos
  end
  
end
