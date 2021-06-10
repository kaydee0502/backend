# frozen_string_literal: true

module Api
  module V1
    class GroupResource < JSONAPI::Resource
      attributes :name, :owner_id, :co_owner_id, :members_count, :student_mentor_id, :owner_name, :co_owner_name
      has_many :group_members
      
      def self.records(options = {})
        # byebug
        user = options[:context][:user]
        # group = options[:context][:group]
        if user.user_type == 0
          batch_leader = Group.find_by(batch_leader_id: user.id)
          if batch_leader.nil?            
            options[:context][:groups] = Group.where(id: GroupMember.find_by(user_id: user.id).group_id)
          else
            options[:context][:groups] = Group.where(batch_leader_id: user.id).or(Group.where(id: GroupMember.find_by(user_id: user.id).group_id ))
          end        
        elsif user.user_type == 1
          options[:context][:groups] = Group.all 
        end
      end      
    end    
  end
end


