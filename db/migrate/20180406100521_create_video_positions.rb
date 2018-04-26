class CreateVideoPositions < ActiveRecord::Migration[5.1]
  def change
    create_table :video_positions do |t|
      t.belongs_to :movie
      t.belongs_to :person
      t.belongs_to :position

      t.timestamps
    end
  end
end
