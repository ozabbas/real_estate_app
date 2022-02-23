class ViewingsController < ApplicationController
  before_action :set_sidebar, except: [:show]
  before_action :set_viewing, only: [:approve_viewing, :decline_viewing, :destroy]

  def index
    ids = Property.where(account_id: current_account.id).ids
    @viewing_requests = Viewing.where(property_id: ids)
    @viewing_requests_sent = Viewing.where(account_id: current_account.id)
  end

  def create
    @viewing = Viewing.new(viewing_params)
    @viewing.account_id = current_account.id
    @property = Property.find(@viewing.property_id)

    Contact.create(account_1: current_account.id, account_2: @property.account_id, match_type: "Viewing Request")

    respond_to do |format|
      if @viewing.save
        format.html { redirect_to property_path(params[:viewing][:property_id]), notice: 'Viewing request was sent to agent.' }
      else
        format.html { render :new }
      end
    end
  end

  def approve_viewing
    if @viewing.update(status: "approved")
      redirect_to viewings_path, flash: { success: "Viewing has been approved" }
    end
  end

  def decline_viewing
    if @viewing.update(status: "declined")
      redirect_to viewings_path, flash: { success: "Viewing has been declined" }
    end
  end

  def destroy
    @viewing.destroy
    respond_to do |format|
      format.html { redirect_to viewings_url, notice: 'Viewing request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_viewing
    @viewing = Viewing.find(params[:id])
  end

  def set_sidebar
    @show_sidebar = true
  end

  def viewing_params
    params.require(:viewing).permit(:date, :notes, :property_id)
  end
end
