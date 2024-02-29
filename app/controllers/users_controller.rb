class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = current_team.users
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        current_team.create_member(@user.id)
        format.html { redirect_to team_user_path(current_team, @user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      if @user.update(user_params)
        format.html { redirect_to team_user_path(current_team, @user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to team_users_path(current_team), notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def assign_roles
    @roles = current_team.roles
    @user = User.find(params[:user_id])
    @user_roles = @user.roles
  end

  def save_roles
    if params[:role_id].present?
      roles = params[:role_id].flatten.compact
      roles.each do |id|
        RolesUser.find_or_create_by(user_id: params[:users_id], role_id: id)
      end
    end
    redirect_to team_user_path(current_team, params[:users_id]), notice: "Roles assigned successfully."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :email, :avatar, :password, :password_confirmation)
    end
end
