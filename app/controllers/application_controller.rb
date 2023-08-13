class ApplicationController < ActionController::Base
        skip_before_action :verify_authenticity_token
        include DeviseTokenAuth::Concerns::SetUserByToken
        include Pundit::Authorization
        rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized 

        before_action :configure_permitted_paramteres, if: :devise_controller?


        def configure_permitted_paramteres
                devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :email, :password, :password_confirmation])
        end

        def user_not_authorized
                @message = "User is not allowed to create, update or destroy"

                render json: {message: @message}, status: 401
        end
end
