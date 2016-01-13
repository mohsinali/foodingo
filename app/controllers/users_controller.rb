class UsersController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized
  include ParseApi

  def bulk_email
    message = { :message_text => "test message" }
    push_notifications(params[:user_object_ids], message)

  end

  def push_notifications(object_ids , message)
    query = Parse::Query.new(Parse::Protocol::CLASS_INSTALLATION).value_in("objectId", object_ids)
    # query.eq('injuryReports', true)
    # query.eq('deviceType', 'android')
    push = Parse::Push.new(message, "objectId")
    push.where = query.where
    push.save
  end

  def index
    @users = get_users
    # authorize User
  end

  def show
    # @user = User.find(params[:id])
    # authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
