class PagesController < ApplicationController
  skip_before_action :verify_user_is_logged_in

  # /
  # root_path
  def registration
    redirect_to home_path if logged_in?
    @user = User.new
  end

  # /about
  # about_path
  def about
  end
end
