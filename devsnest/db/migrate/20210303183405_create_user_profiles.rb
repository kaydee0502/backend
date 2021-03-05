class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
    	t.integer :user_id
    	t.string :full_name
    	t.string :email
    	t.integer :mobile
    	t.string :college_name
    	t.string :branch
    	t.integer :graduation_year
    	t.integer :current_year
    	t.integer :roll_number
    	t.string :nationality
    	t.date :dob
    	t.string :linkedin

      t.timestamps
    end
  end
end
