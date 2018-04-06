class CreateVideoGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :video_genres do |t|
      t.belongs_to :genre
      t.belongs_to :movie
      t.timestamps
    end
  end
end
