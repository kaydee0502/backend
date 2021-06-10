# frozen_string_literal: true

class Group < ApplicationRecord
  # belongs_to :batch
  has_many :group_members
  
  def self.check_auth(group, user)
    unless group.group_members.where(user_id: user.id).present? || group.batch_leader_id == user.id || user.user_type == "admin"  
      return false
    else 
      return true
    end
  end
end
