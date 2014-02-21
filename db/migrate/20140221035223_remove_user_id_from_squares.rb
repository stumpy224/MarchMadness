class RemoveUserIdFromSquares < ActiveRecord::Migration
  def change
    remove_column :squares, :user_id, :integer
  end
end
