class AvailabilitiesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    current_user.availabilities.create(
      available_date: params[:availability][:available_date]
    )

    redirect_to current_user
  end

  def destroy
    availability = current_user.availabilities.find(params[:id])
    availability.destroy

    redirect_to current_user
  end
end