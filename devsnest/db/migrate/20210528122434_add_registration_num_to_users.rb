class AddRegistrationNumToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :registration_num, :string
  end
end
