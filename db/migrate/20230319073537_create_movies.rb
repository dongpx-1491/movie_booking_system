class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.date :release_date
      t.time :duration
      t.string :language
      t.string :cast
      t.string :director
      t.boolean :status

      t.timestamps
    end
  end
end
