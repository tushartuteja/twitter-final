class CreateFollowMappings < ActiveRecord::Migration
  def change
    create_table :follow_mappings do |t|
      t.integer :follower_id, index: true, foreign_key: { to_table: :users }
      t.integer :followee_id, index: true, foreign_key: { to_table: :users }
      t.timestamps null: false
    end
  end
end
