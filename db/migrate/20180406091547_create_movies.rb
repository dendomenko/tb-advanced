class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.date :year
      t.string :poster

      t.timestamps
    end
  end
end
