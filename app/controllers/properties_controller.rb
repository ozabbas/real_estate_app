class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!, only: [:new,:create,:destroy]
  before_action :set_sidebar, except: [:show]

  # GET /properties
  # GET /properties.json
  def index
    @properties = current_account.admin? ? Property.all : Property.where(account_id: current_account.id)
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @agent = @property.account
    @agent_properties = Property.where(account_id: @agent.id).where.not(id: @property.id)
    @schedule_viewing = Viewing.new
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    @property.account_id = current_account.id

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to properties_path, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def email_agent
    # trigger email send
    agent_id = params[:agent_id]
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    message = params[:message]

    ContactMailer.email_agent( agent_id, first_name, last_name, email, message ).deliver_now

    account = Account.find_by_email(email)

    if account.present?
      Contact.create(account_1: current_account.id, account_2: account.id, match_type: "Email Enquiry")
    end

    # response to script
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    def set_sidebar
      @show_sidebar = true
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:name, :address, :price, :rooms, :bathrooms, :parking_spaces, :for_sale, :status, :available_date, :details, :photo, :photo_cache)
    end
end
