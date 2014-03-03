class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :year
      t.string :style
      t.integer :quadrant_id

      t.timestamps
    end
  end
end
