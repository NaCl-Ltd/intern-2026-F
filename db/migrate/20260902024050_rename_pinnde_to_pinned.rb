class RenamePinndeToPinned < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :pinnde, :pinned
  end
end
