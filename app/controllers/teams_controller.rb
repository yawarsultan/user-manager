class TeamsController < ApplicationController
  before_action :check_login_user
  before_action :find_team, only: %w[edit update destroy]

  def index
    @teams = current_user.teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      @team.create_member(current_user.id)
      respond_to do |format|
        format.html { redirect_to teams_path(team_id: current_team&.id), notice: "Team Added Successfully" }
        format.json { render :show, status: :created, location: @team }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      respond_to do |format|
        format.html { redirect_to teams_path(team_id: current_team&.id), notice: "Team Updated Successfully" }
        format.json { render :show, status: :created, location: @team }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path(team_id: current_team&.id), notice: "Team destroyed Successfully"
  end

  def assign_members
    @team = Team.find(params[:teams_id])
    @users = User.where.not(id: current_user.id)
    @assigned_users = @team.users
  end

  def save_members
    users = params[:users_ids].flatten.compact
    users.each do |id|
      TeamMember.find_or_create_by(user_id: id, team_id: params[:teams_id])
    end
    redirect_to teams_path(team_id: current_team&.id), notice: "Members assigned successfully."
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :user_id)
  end

  def find_team
    @team = Team.find(params[:id])
  end
end
