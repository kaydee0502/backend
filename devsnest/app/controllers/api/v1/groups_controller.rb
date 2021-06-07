# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth
      before_action :deslug, only: %i[show]
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

      def deslug
        slug_name = params[:id]
        group = Group.find_by(slug: slug_name)
        return render_not_found unless group.present?
        params[:id] = group.id
      end

      def index
        if @current_user.user_type == 0
          @groups = Group.find_by(id: params[:id])
        elsif @current_user.user_type == 1
          @groups = Group.where(batch_leader_id: @current_user.id)
        elsif @current_user.user_type == 2
          @groups = Group.all 
        end
        
        response = { :data => @groups, :my_group => GroupMember.find_by(user_id: @current_user.id).group_id }

        render :json => response

      end
    end
  end
end
