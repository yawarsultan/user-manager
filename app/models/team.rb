class Team < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :team_members, dependent: :destroy
  has_many :users, through: :team_members

  has_many :roles, dependent: :destroy

  def create_member(user_id)
    TeamMember.create(team_id: id, user_id: user_id)
  end

  def check_owner(member_id)
    return true if user_id == member_id
    return false
  end
end
