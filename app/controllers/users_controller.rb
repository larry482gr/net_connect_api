class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :current_network_users]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  def current_network_users
    @users = @user.router.users
                 .select(:id, :local_ip, :local_port, :external_address, :latitude, :longitude)
                 .where.not(id: @user.id)

    render json: @users
  end

  def unregistered_network_users
    router = Router.find_by(ssid: params[:ssid], mac_address: params[:mac_address])
    if router.nil?
      @users = []
    else
      @users = router.users
                   .select(:id, :local_ip, :local_port, :external_address, :latitude, :longitude)
    end

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    params = user_params
    router = Router.find_by(mac_address: params[:router_attributes][:mac_address])
    unless router.nil?
      params.delete(:router_attributes)
      @user.router = router
    end

    if @user.update(params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:fb_user_id, :fb_access_token, :router_id, :local_ip, :local_port, :external_address,
                                   :latitude, :longitude,
                                   user_profile_attributes: [:first_name, :last_name, :photo, :bg_photo,
                                                             :about_me, :age, :birthday, :gender],
                                   router_attributes: [:ssid, :mac_address])
    end
end
