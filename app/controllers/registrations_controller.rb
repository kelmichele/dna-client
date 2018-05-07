class RegistrationsController < Devise::RegistrationsController
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname])
  end


  private

    def sign_up_params
      params.require(:user).permit( :firstname,
                                    :lastname,
                                    :email,
                                    :password,
                                    :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit( :firstname,
                                    :lastname,
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    :current_password)
    end
end
