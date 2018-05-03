class CreateMovieRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_ratings do |t|
      t.belongs_to :user
      t.belongs_to :movie
      t.decimal :rating
      t.timestamps
    end
  end
end
