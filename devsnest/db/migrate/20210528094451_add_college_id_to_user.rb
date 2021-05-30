class AddCollegeIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :college_id, :integer
    add_column :users, :registration_num, :string
  end
end
