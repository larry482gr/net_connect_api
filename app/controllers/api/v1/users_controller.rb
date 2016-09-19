module Api::V1
  class UsersController < ApiController
    before_action :set_user, only: [:show]
    before_action :authenticate, except: [:unregistered_nearby_users, :create]

    # GET /users
    def index
      @users = [] # User.all

      render json: @users
    end

    def nearby_users
      # User.all.joins(:user_profile)
      # TODO Refactor this and send user discovery methods to model or an independent module

      if @current_user.geocoded?
        distance = 0.020 # 20 meters
        center_point = [@current_user.latitude, @current_user.longitude]
        box = Geocoder::Calculations.bounding_box(center_point, distance, units: :km)
        Venue.within_bounding_box(box)

        @users = @current_user.router.users
                     .or(User.within_bounding_box(box))
                     .joins(:user_profile)
                     .select(:fb_user_id, :latitude, :longitude,
                             'user_profiles.first_name', 'user_profiles.middle_name', 'user_profiles.last_name',
                             'user_profiles.picture', 'user_profiles.gender', 'user_profiles.age_min', 'user_profiles.age_max')
                     .where.not(id: @current_user.id)
      else
        @users = @current_user.router.users
                     .joins(:user_profile)
                     .select(:fb_user_id, :latitude, :longitude,
                             'user_profiles.first_name', 'user_profiles.middle_name', 'user_profiles.last_name',
                             'user_profiles.picture', 'user_profiles.gender', 'user_profiles.age_min', 'user_profiles.age_max')
                     .where.not(id: @current_user.id)
      end

      render json: @users
    end

    def unregistered_nearby_users
      router = Router.find_by(ssid: params[:ssid], mac_address: params[:mac_address])
      if router.nil?
        @users = []
      else
        @users = router.users.joins(:user_profile) # User.all.joins(:user_profile)
                     .select(:fb_user_id, :latitude, :longitude,
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
      set_user_router (@user)

      unless @user.valid?
        user = User.find_by(fb_user_id: @params[:fb_user_id])
        render json: user, status: :ok, location: v1_user_path(user.id) and return
      end

      if @user.save
        render json: @user, status: :created, location: v1_user_path(@user.id)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      @params = user_params
      set_user_router (@current_user)

      if @current_user.update(@params)
        render status: :no_content # json: @user
      else
        render json: @current_user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      @current_user.destroy
    end

    # POST /users/service_ping
    def service_ping
      @params = user_params
      set_user_router (@current_user)

      @service_ping = ServicePing.new(@params)
      @service_ping.user = @current_user
      @service_ping.router = @current_user.router

      if @service_ping.save
        render json: @service_ping, status: :created
      else
        render json: @service_ping.errors, status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find_by(fb_user_id: params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:connection_instance, :fb_user_id, :fb_access_token, :router_id,
                                     :latitude, :longitude,
                                     user_profile_attributes: [:first_name, :middle_name, :last_name,
                                                               :fb_link, :email, :picture, :gender,
                                                               :age_min, :age_max,
                                                               :bg_picture, :about_me, :birthday],
                                     router_attributes: [:ssid, :mac_address])
      end

      def set_user_router (user)
        if @params[:router_attributes].nil? or @params[:router_attributes][:mac_address].nil?
          user.router = nil
        else
          router = Router.find_by(mac_address: @params[:router_attributes][:mac_address])
          unless router.nil?
            @params.delete(:router_attributes)
            user.router = router
          end
        end
      end
  end
end
