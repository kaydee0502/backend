# frozen_string_literal: true

module Api
  module V1
    class GroupMembersController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth
      before_action :check_authorization

      def context
        { user: @current_user }
      end

      def check_authorization
        group = Group.find_by(id: params[:group_id])
        return render_not_found unless group.present?
        if !(group.group_members.where(user_id: @current_user.id).present? || group.batch_leader_id == @current_user.id || @current_user.user_type == 2)
          return render_forbidden
        end   
      end
      def show
        if @current_user.user_type == 2
          @members = GroupMembers.all
          return render :json => @members
        end
      end
    end
  end
end
