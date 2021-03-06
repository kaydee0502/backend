module Api
  module V1
  	  class UserProfilesController < ApplicationController
      	include JSONAPI::ActsAsResourceController
      	before_action :authorize_member, only: [:update]
      	def context
      		{user: @current_user}
      	end

	    def authorize_member
	        return render_forbidden unless @current_user.id == UserProfile.find_by(id: params[:id]).user_id
	    end
	    
	    # def create
	    # 	email = @current_user.email
	    # 	user_id = @current_user.id
	    # 	byebug

	    # 	unless user.persisted?
	    # 	UserProfile.create(email:email, user_id: user_id)
	    #   end
	    # end

      end
    end
 end