# frozen_string_literal: true

module Api
  module V1
    class ScrumResource < JSONAPI::Resource
      attributes :user_id, :group_id, :group_member_id, :data, :created_at, :updated_at
    end
  end
end
