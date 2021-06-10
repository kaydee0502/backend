# frozen_string_literal: true

class Group < ApplicationRecord
  # belongs_to :batch
  has_many :group_members
  
  def check_auth(user)
    if self.group_members.where(user_id: user.id).present? || self.batch_leader_id == user.id || user.user_type == "admin"  
      return true
    end
    false 
  end
end