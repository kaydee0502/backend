module Api
  module V1
  	  class UserProfilesController < ApplicationController
      	include JSONAPI::ActsAsResourceController
      	before_action :authorize_member, only: [:update]
      	def context
      		{user: @current_user}
      	end

	    def authorize_member
	        return render_forbidden unless @current_user.id == params[:id].to_i
	    end

      end
    end
 end