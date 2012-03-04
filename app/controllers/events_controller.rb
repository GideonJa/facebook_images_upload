class EventsController < ApplicationController

  def show
    puts current_user.events.count
    @event = current_user.events.find(params[:id])
  end
  
end
