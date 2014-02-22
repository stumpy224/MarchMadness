class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :participant_id
      t.integer :round
      t.string :year

      t.timestamps
    end
  end
end
