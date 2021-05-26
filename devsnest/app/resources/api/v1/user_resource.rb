# frozen_string_literal: true

module Api
  module V1
    class UserResource < JSONAPI::Resource
      attributes :email, :name, :password, :discord_id, :google_id, :web_active, :username, :score, :discord_active, :bot_token
      attributes :group_id

      def fetchable_fields
        if context[:user].nil? || context[:user].id == @model.id
          super - [:password]
        else
          super - [:password, :email]
        end
      end

      def group_id
        return nil if context[:user].nil?

        member = GroupMember.where(user_id: context[:user].id).first
        member.present? ? member.group_id : nil
      end

      def bot_token
        @model.bot_token = Digest::SHA1.hexdigest([Time.now, rand].join)
        @model.save
      end

    end
  end
end
