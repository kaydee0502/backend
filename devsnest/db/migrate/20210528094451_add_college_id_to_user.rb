class AddCollegeIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :college_id, :integer
  end
end
