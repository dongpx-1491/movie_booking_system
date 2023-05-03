class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.float :rating
      t.integer :duration_min
      t.datetime :release_time
      t.string :language
      t.string :director
      t.string :cast
      t.integer :age_range
      t.integer :status, default: 0
      t.text :banner_data
      t.text :image_data
      t.timestamps
    end
  end
end
