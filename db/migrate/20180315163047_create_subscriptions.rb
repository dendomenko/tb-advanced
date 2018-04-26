class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
    end
    add_reference :subscriptions, :user, foreign_key: true
    add_reference :subscriptions, :question, foreign_key: true
    add_index :subscriptions, [:user_id, :question_id], unique: true
  end
end
