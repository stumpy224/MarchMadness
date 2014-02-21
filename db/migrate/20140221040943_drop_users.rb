class DropUsers < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
