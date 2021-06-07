class AddOwnerNameToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :owner_name, :string
    add_column :groups, :co_owner_name, :string
  end
end
