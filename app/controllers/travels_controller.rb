class TravelsController < ApplicationController

  # /:user_slug/travels
  # travels_path(:user_slug)
  def index
    redirect_to travels_path(current_user) unless params_user_exists?
    if params_user_is_current_user?
      @travel = current_user.travels.build.tap{|travel| travel.build_destination}
    end
  end

  # /:user_slug/travels
  # travels_path(:user_slug)
  def create
    redirect_to travels_path(current_user) unless params_user_is_current_user?
    @travel = @user.travels.build(travel_params)
    if travel_dates_valid? && @travel.save
      respond_to do |format|
        format.html { redirect_to travels_path(@user) }
        format.json { render :json => @travel }
      end
    else render :index and return
    end
  end

  # /travels/:id
  # travel_path(:id)
  def show
    redirect_to travels_path(current_user) unless params_travel_exists?
    respond_to do |format|
      format.html
      format.json { render :json => @travel }
    end
  end

  # /travels/:id/edit
  # edit_travel_path(:id)
  def edit
    redirect_to travels_path(current_user) unless params_travel_exists_and_belongs_to_current_user?
  end

  # /travels/:id
  # travel_path(:id)
  def update
    redirect_to travels_path(current_user) unless params_travel_exists_and_belongs_to_current_user?
    if travel_dates_valid? && @travel.update(travel_params) then redirect_to travels_path(current_user)
    else render :edit and return
    end
  end

  # /travels/:id
  # travel_path(:id)
  def destroy
    @travel.destroy if params_travel_exists_and_belongs_to_current_user?
    redirect_to travels_path(current_user)
  end

  private

  def travel_params
    params.require(:travel).permit(:purpose, :start_date, :end_date, :destination_attributes => [:name])
  end

  def params_travel_exists?
    !!( @travel = Travel.find_by(:id => params[:id]) )
  end

  def params_travel_exists_and_belongs_to_current_user?
    @travel.user_id == current_user.id if params_travel_exists?
  end

  def travel_dates_valid?
    %w[start_date end_date].all? do |attribute|
      if travel_params[attribute].blank?
        true
      else
        if !!( travel_params[attribute] =~ /\A\d{4}-\d{1,2}-\d{1,2}\z/ )
          yyyymmdd = travel_params[attribute].split(/\D/).map(&:to_i)
          !!Date.new(*yyyymmdd) rescue ( @travel.errors.add(attribute.to_sym, "is invalid"); false )
        else
          @travel.errors.add(attribute.to_sym, "format is invalid"); false
        end
      end
    end
  end
end
