class AddSlugToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :slug, :string
  end
end
