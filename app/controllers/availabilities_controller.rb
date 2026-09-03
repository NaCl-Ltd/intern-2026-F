class AvailabilitiesController < ApplicationController
    before_action :set_user, only: [:edit, :update]
    def edit
    end
    def update
        if @user.update(user_params)
            redirect_to @user, notice: "Availability updated successfully."
        end
    end
    private
    def set_user
      @user = User.find(params[:user_id])
    end
    def user_params
        Rails.logger.debug"---------------------------------------"
        Rails.logger.debug params
      params.require(:user).permit(:available_dates)
    end
end