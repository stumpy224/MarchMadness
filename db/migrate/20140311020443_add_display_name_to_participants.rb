class AddDisplayNameToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :display_name, :string, null: true
  end
end
