module Api
  module V1
    class UserProfileResource < JSONAPI::Resource
      attributes :full_name, :email, :mobile, :college_name, :branch, :graduation_year, :current_year, :roll_number, :nationality, :dob, :linkedin, :user_id
    end
  end
end
