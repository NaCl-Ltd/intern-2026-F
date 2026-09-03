class AddPinndeToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :pinned_id, :integer
  end
end

