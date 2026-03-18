class ApplicationController < ActionController::Base
  include Authentication

   private

  def require_admin!
    redirect_to root_path, alert: "No tienes permisos." unless Current.user.admin?
  end
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
