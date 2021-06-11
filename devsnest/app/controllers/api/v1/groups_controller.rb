# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      include JSONAPI::ActsAsResourceController
      before_action :simple_auth
      before_action :deslug, only: %i[show]
      before_action :check_authorization, only: %i[show]
      before_action :parameterize, only: %i[create update]

      def context
        { user: @current_user }
      end

      def check_authorization
        group = Group.find_by(id: params[:id])
        return render_not_found unless group.present?
        
        return render_forbidden unless group.check_auth(@current_user)
      
      end

      def parameterize
        params[:data][:attributes][:slug] = params[:data][:attributes][:name].parameterize
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