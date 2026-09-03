class CreateAvailabilities < ActiveRecord::Migration[8.1]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.date :available_date

      t.timestamps
    end
    add_index :availabilities, [:user_id, :available_date], unique: true
    add_index :availabilities, [:available_date, :user_id], unique: true
  end
end
