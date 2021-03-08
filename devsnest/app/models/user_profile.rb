# frozen_string_literal: true

class UserProfile < ApplicationRecord
  belongs_to :user

  validates :mobile,
            numericality: true,
            length: { minimum: 10, maximum: 12 }

  validates :graduation_year,
            numericality: true,
            length: { minimum: 4, maximum: 4 }
end
