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
        if !(group.group_members.where(user_id: @current_user.id).present? || group.batch_leader_id == @current_user.id || @current_user.user_type == 1)
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
          batch_leader = Group.find_by(batch_leader_id: @current_user.id)
          if batch_leader.nil?            
            @groups = Group.where(id: GroupMember.find_by(user_id: @current_user.id).group_id )
          else
            @groups = Group.where(batch_leader_id: @current_user.id).or(Group.where(id: GroupMember.find_by(user_id: @current_user.id).group_id ))
          end        
        elsif @current_user.user_type == 1
          @groups = Group.all 
        end        
        response = { :data => @groups, :my_group_id => GroupMember.find_by(user_id: @current_user.id).group_id }
        render :json => response
      end
    end
  end
end
