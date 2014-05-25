class UsersController < ApplicationController
  before_filter :authenticate_user!

  def edit
  end

  def update
    @profile = current_user.update_attributes!(user_params)
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end