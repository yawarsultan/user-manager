class Role < ApplicationRecord
  belongs_to :team
  has_many :roles_users
  has_many :users, through: :roles_users
end
