class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.text :description
      t.text :permissions, array: true, default: []
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
