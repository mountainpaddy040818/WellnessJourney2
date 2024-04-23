class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    health_records_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = "You are logged in as a Guest User."
    redirect_to user_path(user)
  end

  protected
    # # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :name])
    end
end
