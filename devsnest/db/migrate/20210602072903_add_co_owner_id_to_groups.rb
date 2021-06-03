class AddCoOwnerIdToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :co_owner_id, :int
  end
end
