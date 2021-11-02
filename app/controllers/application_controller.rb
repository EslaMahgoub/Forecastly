class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  before_action :set_locale
    
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please Login"
        redirect_to login_path
      end
    end
end

