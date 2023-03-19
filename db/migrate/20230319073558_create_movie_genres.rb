class CreateMovieGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_genres do |t|

      t.timestamps
    end

    add_reference(:movie_genres, :movie, foreign_key: true)
    add_reference(:movie_genres, :genre, foreign_key: true)
  end
end
