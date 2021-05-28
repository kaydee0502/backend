class RemoveColumnFromCollege < ActiveRecord::Migration[6.0]
  def change
    remove_column :colleges, :user_id
  end
end
