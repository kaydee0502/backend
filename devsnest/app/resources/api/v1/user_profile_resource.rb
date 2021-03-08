# frozen_string_literal: true

module Api
  module V1
    class UserProfileResource < JSONAPI::Resource
      attributes :full_name, :mobile, :college_name, :branch, :graduation_year, :roll_number, :nationality, :dob, :linkedin, :user_id
    end
  end
end
