# frozen_string_literal: true

module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :email, :name, :password, :discord_id, :web_active, :username, :score, :discord_active, :batch, :grad_status, :grad_specialization, :grad_year,
                 :github_url, :linkedin_url, :resume_url, :dob, :registration_num, :college_id
      attributes :group_id, :group_name 
      attributes :college_name
      attributes :solved, :total_by_difficulty
      attributes :activity
      
      def fetchable_fields
        if context[:user].nil? || context[:user].id == @model.id
          super - [:password, :college_id]
        else
          super - [:password, :email, :college_id]
        end
      end

      def self.updatable_fields(context)
        super - [:score, :group_id, :group_name]
      end

      def group_id
        return nil if context[:user].nil?
        member = GroupMember.where(user_id: context[:user].id).first
        member.present? ? member.group_id : nil
      end

      def group_name
        return nil if context[:user].nil?
        member = GroupMember.where(user_id: context[:user].id).first 
        groupId = member.present? ? member.group_id : nil
        group =  Group.where(id: groupId).first
        group.present? ? group.name : nil
      end

      def college_name
        return nil if context[:user].nil?
        return nil if context[:user].college_id.nil?
        cid = context[:user].college_id      
        cid.present? ? College.where(id: cid).first.name : nil
      end

      def solved
        return nil if context[:user].nil?
        Submission.count_solved(context[:user].id)
      end   

      def total_by_difficulty
        return nil if context[:user].nil?
        Content.split_by_difficulty
      end
      
      def activity
        return nil if context[:user].nil?
        dates = Hash.new
        Submission.where(status:"done",user_id:context[:user].id).or(Submission.where(status:"doubt",user_id:context[:user].id)).all.each do |user|
          if dates.key?(user.updated_at.to_date)
            dates[user.updated_at.to_date] += 1
          else
            dates[user.updated_at.to_date] = 1
          end
        end
        return dates
      end
    end
  end
end