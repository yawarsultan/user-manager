class CreateRolesUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :roles_users do |t|
      t.integer :role_id
      t.integer :user_id

      t.timestamps
    end
  end
end
