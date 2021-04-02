# frozen_string_literal: true

module Api
  module V1
    class ScrumResource < JSONAPI::Resource
      attributes :user_id, :group_id, :group_member_id, :data, :attendance, :saw_last_lecture,
                 :till_which_tha_you_are_done, :what_cover_today, :reason_for_backlog, :rate_yesterday_class

      def self.updatable_fields(context)
        scrum_group_owner_id = Group.find_by(id: context[:scrum].group_id).owner_id
        if context[:user].id == scrum_group_owner_id
          super - %i[user_id group_id group_member_id]
        else
          super - %i[attendance user_id group_id group_member_id]
        end
      end

      def self.records(options = {})
        group_id = GroupMember.find_by(user_id: options[:context][:user].id).group_id
        super(options).where(group_id: group_id, created_at: Date.current.beginning_of_day..Date.current.end_of_day)
      end
    end
  end
end
