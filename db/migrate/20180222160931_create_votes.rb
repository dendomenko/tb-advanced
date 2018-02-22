class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :votable_id
      t.string :votable_type
      t.integer :rate
      t.timestamps
    end
    add_reference :votes, :user, foreign_key: true
    add_index :votes, [:votable_id, :votable_type]
  end
end
