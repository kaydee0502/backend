class UserProfile < ApplicationRecord
	belongs_to :user

	validates :mobile,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 10 }

	validates :graduation_year,:presence => true,
             :numericality => true,
             :length => { :minimum => 4, :maximum => 4 }

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end
