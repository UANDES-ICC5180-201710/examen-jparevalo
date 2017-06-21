class CreatePurcharses < ActiveRecord::Migration[5.0]
  def change
    create_table :purcharses do |t|
      t.integer :user_id, on_delete: :cascade
      t.integer :game_id, on_delete: :cascade

      t.timestamps
    end
  end
end
