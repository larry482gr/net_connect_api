class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :current_network_users]

  # GET /users
  def index
    @users = [] # User.all

    render json: @users
  end

  def current_network_users
    @users = @user.router.users.joins(:user_profile)
                 .select(:local_ip, :local_port, :external_address, :latitude, :longitude,
                         'user_profiles.first_name', 'user_profiles.middle_name', 'user_profiles.last_name',
                         'user_profiles.picture', 'user_profiles.gender', 'user_profiles.age_min', 'user_profiles.age_max')
                 .where.not(id: @user.id)

    render json: @users
  end

  def unregistered_network_users
    router = Router.find_by(ssid: params[:ssid], mac_address: params[:mac_address])
    if router.nil?
      @users = []
    else
      @users = router.users.joins(:user_profile)
                   .select(:local_ip, :local_port, :external_address, :latitude, :longitude,
                           'user_profiles.first_name', 'user_profiles.middle_name', 'user_profiles.last_name',
                           'user_profiles.picture', 'user_profiles.gender', 'user_profiles.age_min', 'user_profiles.age_max')
    end

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @params = user_params
    @user = User.new(@params)
    set_user_router

    unless @user.valid?
      user = User.find_by(@params[:fb_user_id])
      redirect_to user and return
    end

    if @user.save
      render status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    @params = user_params
    set_user_router
    set_gender_index unless @params[:user_profile_attributes].nil? or @params[:user_profile_attributes][:gender].nil?

    if @user.update(@params)
      render status: :no_content # json: @user
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
      @user = User.find_by(fb_user_id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:fb_user_id, :fb_access_token, :router_id, :local_ip, :local_port, :external_address,
                                   :latitude, :longitude,
                                   user_profile_attributes: [:first_name, :middle_name, :last_name,
                                                             :fb_link, :email, :picture, :gender,
                                                             :age_min, :age_max,
                                                             :bg_picture, :about_me, :birthday],
                                   router_attributes: [:ssid, :mac_address])
    end

    def set_user_router
      return if @params[:router_attributes].nil? or @params[:router_attributes][:mac_address].nil?

      router = Router.find_by(mac_address: @params[:router_attributes][:mac_address])
      unless router.nil?
        @params.delete(:router_attributes)
        @user.router = router
      end
    end

    def set_gender_index
      gender = @params[:user_profile_attributes][:gender]
      if gender.to_s == 'male'
        gender = 1
      elsif gender.to_s == 'female'
        gender = 2
      else
        gender = 0
      end

      @params[:user_profile_attributes][:gender] = gender
    end
end
