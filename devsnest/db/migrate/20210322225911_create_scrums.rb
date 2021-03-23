class CreateScrums < ActiveRecord::Migration[6.0]
  def change
    create_table :scrums do |t|
    	t.integer :group_id
    	t.integer :user_id
      t.integer :group_member_id
    	t.boolean :attendence
    	t.string :data

      t.timestamps
    end
    add_index :scrums, :user_id
    add_index :scrums, :group_id
    add_index :scrums, :group_member_id
  end
end
