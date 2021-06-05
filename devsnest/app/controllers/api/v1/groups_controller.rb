# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth
      before_action :check_authorization, only: %i[show]

      def context
        { user: @current_user }
      end

      def check_authorization
        group = Group.find_by(id: params[:id])
        return render_not_found unless group.present?
        if !(group.group_members.where(user_id: @current_user.id).present? || group.batch_leader_id == @current_user.id || @current_user.user_type == 2)
          return render_forbidden
        end   
      end

      def index
        if @current_user.user_type == 0
          @groups = Group.find_by(id: params[:id])
          return render :json => @groups
        elsif @current_user.user_type == 1
          @groups = Group.where(batch_leader_id: @current_user.id)
          return render :json => @groups
        elsif @current_user.user_type == 2
          @groups = Group.all
          return render :json => @groups
        end
      end
    end
  end
end
