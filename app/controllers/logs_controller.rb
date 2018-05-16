class LogsController < ApplicationController

  # /travels/:travel_id/logs/new
  # new_travel_log_path(:travel_id)
  def new
    redirect_to travels_path(current_user) unless params_travel_exists_and_belongs_to_current_user?
    @log = @travel.logs.build
  end

  # /travels/:travel_id/logs
  # travel_logs_path(:travel_id)
  def create
    redirect_to travels_path(current_user) unless params_travel_exists_and_belongs_to_current_user?
    @log = @travel.logs.build(log_params)
    if @log.save then redirect_to travel_path(@travel)
    else render :new and return
    end
  end

  # /travels/:travel_id/logs/:id
  # travel_log_path(:travel_id, :id)
  def show
    redirect_to travels_path(current_user) unless params_travel_log_exists?
  end

  # /travels/:travel_id/logs/:id/edit
  # edit_travel_log_path(:travel_id, :id)
  def edit
    redirect_to travels_path(current_user) unless params_travel_log_exists_and_belongs_to_current_user?
  end

  # /travels/:travel_id/logs/:id
  # travel_log_path(:travel_id, :id)
  def update
    redirect_to travels_path(current_user) unless params_travel_log_exists_and_belongs_to_current_user?
    if @log.update(log_params) then redirect_to travel_log_path(@travel, @log)
    else render :edit and return
    end
  end

  # /travels/:travel_id/logs/:id
  # travel_log_path(:travel_id, :id)
  def destroy
    @log.destroy if params_travel_log_exists_and_belongs_to_current_user?
    redirect_to travel_path(@travel)
  end

  private

  def log_params
    params.require(:log).permit(:title, :content)
  end

  def params_travel_exists?
    !!( @travel = Travel.find_by(:id => params[:travel_id]) )
  end

  def params_travel_exists_and_belongs_to_current_user?
    @travel.user_id == current_user.id if params_travel_exists?
  end

  def params_travel_log_exists?
    !!( @log = @travel.logs.find_by(:id => params[:id]) ) if params_travel_exists?
  end

  def params_travel_log_exists_and_belongs_to_current_user?
    @log.user.id == current_user.id if params_travel_log_exists?
  end
end
