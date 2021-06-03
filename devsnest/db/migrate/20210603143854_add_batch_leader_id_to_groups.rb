class AddBatchLeaderIdToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :batch_leader_id, :integer
  end
end
