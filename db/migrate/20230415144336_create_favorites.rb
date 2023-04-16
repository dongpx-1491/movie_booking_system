class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: true, foreign_key: true
      t.references :movie, null: true, foreign_key: true
      t.timestamps
    end
  end
end
