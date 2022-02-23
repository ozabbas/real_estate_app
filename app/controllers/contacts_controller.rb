class ContactsController < ApplicationController

  def index
    @contacts = Contact.matches_for current_account.id
    @show_sidebar = true
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
