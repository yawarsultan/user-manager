class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_team
  before_action :fetch_teams
  before_action :user_roles

  def check_login_user
    return redirect_to new_user_session_path if current_user.blank?
  end

  def current_team
    @current_team || Team.find_by(id: params[:team_id]) || current_user&.teams.first
  end

  def fetch_teams
    return @user_teams = [] if current_user.blank?
    @user_teams = current_user.teams
  end

  def user_roles
    @user_roles = 
    if current_user.present? && current_team.present?
      @user_roles = current_user.roles.where(team_id: current_team.id)&.pluck(:permissions)&.flatten
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
