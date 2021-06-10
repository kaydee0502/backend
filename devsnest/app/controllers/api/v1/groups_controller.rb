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
        unless Group.check_auth(@current_user)
          return render_forbidden
        end        
      end

      def deslug
        slug_name = params[:id]
        group = Group.find_by(slug: slug_name)
        return render_not_found unless group.present?
        params[:id] = group.id
      end
    end
  end
end
