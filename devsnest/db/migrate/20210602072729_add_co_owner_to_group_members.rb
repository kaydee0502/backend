class AddCoOwnerToGroupMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :group_members, :co_owner, :int
  end
end
