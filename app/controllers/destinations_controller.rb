class DestinationsController < ApplicationController

  # /:user_slug/destinations
  # destinations_path(:user_slug)
  def index
    redirect_to destinations_path(current_user) unless params_user_exists?
  end

  # /destinations/:slug
  # destination_path(:slug)
  def show
    redirect_to destinations_path(current_user) unless params_destination_exists?
  end

  private

  def params_destination_exists?
    !!( @destination = Destination.find_by(:slug => params[:slug]) )
  end
end
