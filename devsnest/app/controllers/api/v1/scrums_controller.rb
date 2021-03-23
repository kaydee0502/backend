# frozen_string_literal: true

module Api
  module V1
    class ScrumsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth, only: %i[index show create]
      before_action :authorize_member, only: %i[update delete]
      before_action :authorize_collection, only: [:show]

      def context
        { user: @current_user,
          scrum:  Scrum.find_by(id: params[:id])}
      end

      def authorize_member
          scrum_group_id = Scrum.find_by(id: params[:id]).group_id
          scrum_group_owner_id = Group.find_by(id: scrum_group_id).owner_id
        return render_forbidden unless @current_user.id == Scrum.find_by(id: params[:id]).user_id || context[:user].id == scrum_group_owner_id
      end

      def authorize_collection
        return render_forbidden unless GroupMember.find_by(user_id: @current_user.id).group_id == Scrum.find_by(id: params[:id]).group_id
      end


      def create
        batchmate_user_id = params['data']['attributes']['user_id']
        attendence = params['data']['attributes']['attendence']
        data = params['data']['attributes']['data']
        saw_last_lecture = params['data']['attributes']['saw_last_lecture']
        till_which_tha_you_are_done = params['data']['attributes']['till_which_tha_you_are_done']
        what_cover_today = params['data']['attributes']['what_cover_today']
        reason_for_backlog = params['data']['attributes']['reason_for_backlog']
        if batchmate_user_id == nil
          return render_forbidden unless Scrum.find_by(user_id: @current_user.id, created_at: Date.current.beginning_of_day..Date.current.end_of_day) == nil
        else
          return render_forbidden unless Scrum.find_by(user_id: batchmate_user_id, created_at: Date.current.beginning_of_day..Date.current.end_of_day) == nil
        end
        scrum = Scrum.create_scrum(context,batchmate_user_id, data, attendence,saw_last_lecture, till_which_tha_you_are_done, what_cover_today,reason_for_backlog)
        if scrum != nil
          render_success(scrum.as_json.merge("type": 'scrum'))
        else
          render_forbidden
        end
      end

    end
  end
end
