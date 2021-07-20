class ApplicationController < ActionController::Base
    
    before_action :set_search
    before_action :configure_permitted_parameters, 
        if: :devise_controller?

    add_flash_types :info, :error, :warning

    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    include PublicActivity::StoreController #save current_user using gem public_activity

    def set_search
        @q=Event.search(params[:q])
    end

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :designation, :company, :address,:avatar])
        end
    private

    def after_sign_out_path_for(resource_or_scope)
        root_path
    end

    def user_not_authorized
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
    end

    def require_user_logged_in!
        redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
    end
end
