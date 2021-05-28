class College < ApplicationRecord

  def self.create_college(college_name)
    college = College.new
    college.name = college_name
    p college_name
    college.save
  end
end