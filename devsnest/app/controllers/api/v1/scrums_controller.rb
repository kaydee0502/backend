# frozen_string_literal: true

module Api
  module V1
    class ScrumsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth, only: %i[index show create update]

      def context
        { user: @current_user }
      end

      def create
        return render_error('User not found') if @current_user.nil?

        data = params['data']['attributes']['data']

        group_member = GroupMember.where(user_id: @current_user.id).first
        scrum = Scrum.create(user_id: @current_user.id, group_id: group_member.group_id, group_member_id: group_member.id, data: data)
        return render_success(scrum.as_json.merge("type": 'scrum'))
      end
    end
  end
end
