# frozen_string_literal: true

class AddGradStartToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :grad_start, :integer
    add_column :users, :grad_end, :integer
  end
end
