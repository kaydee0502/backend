# frozen_string_literal: true

module Api
  module V1
    class GroupResource < JSONAPI::Resource
      attributes :name, :owner_id, :co_owner_id, :members_count, :student_mentor_id, :owner_name, :co_owner_name, :batch_leader_id, :slug, :my_group
      has_many :group_members
      
      def self.records(options = {})
        user = options[:context][:user]        
        group = options[:context][:group]
        if user.user_type == "user"
          batch_leader = Group.find_by(batch_leader_id: user.id)
          if batch_leader.nil?            
            group_ids = Group.where(id: GroupMember.find_by(user_id: user.id).group_id).ids
          else
            group_ids = Group.where(batch_leader_id: user.id).or(Group.where(id: GroupMember.find_by(user_id: user.id).group_id )).ids
          end        
        elsif user.user_type == "admin"
          group_ids = Group.all.ids
        end        
        super(options).where(id: group_ids)
      end
      def my_group
        GroupMember.find_by(user_id: context[:user].id).group_id
      end       
    end    
  end
end


