# frozen_string_literal: true

module Api
  module V1
    class GroupMembersController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth
      before_action :check_authorization, except: %i[update_user_group]
      before_action :bot_auth, only: %i[update_user_group]

      def context
        { user: @current_user }
      end

      def check_authorization
        group = Group.find_by(id: params[:group_id])
        return render_not_found unless group.present?

        return render_forbidden unless group.check_auth(@current_user)
      end

      def update_user_group
        discord_id = params['data']['attributes']['discord_id']
        updated_group_name = params['data']['attributes']['updated_group_name']
        is_team_leader = params['data']['attributes']['is_team_leader']
        is_vice_team_leader = params['data']['attributes']['is_vice_team_leader']

        super if discord_id.nil?

        user = User.find_by(discord_id: discord_id)
        return render_error('User not found') if user.nil?

        current_group_member = GroupMember.find_by(user_id: user.id)
        current_group = Group.find_by(id: current_group_member.group_id) if current_group_member.present?

        if updated_group_name.present?
          # update the user's group
          new_group = Group.find_by(name: updated_group_name)
          # create group if not already exists
          new_group = Group.create(name: updated_group_name) if new_group.nil?

          if current_group_member.present?
            # user is member of a group just need to update it
            current_group_member.update(group_id: new_group.id)
          else
            # user was not part of any group need to create member
            GroupMember.create(user_id: user.id, group_id: new_group.id)
          end

          if is_team_leader
            # is team leader of his group
            Group.update(owner_id: user.id) if user.id != new_group.owner_id
          elsif is_vice_team_leader
            # is vice team leader of his group
            Group.update(co_owner_id: user.id) if user.id != new_group.co_owner_id
          end
        elsif current_group_member.present?
          # delete the user from group
          current_group_member.destroy
        end

        render_success({})
      end
    end
  end
end
