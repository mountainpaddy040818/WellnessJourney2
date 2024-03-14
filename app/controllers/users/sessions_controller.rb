class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "You logged in as a Guest User."
  end
end
