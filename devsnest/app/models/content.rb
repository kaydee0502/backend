# frozen_string_literal: true

class Content < ApplicationRecord
  enum data_type: %i[question video article topic subtopic]
  enum difficulty: %i[easy medium hard]
  enum question_type: %i[class assignment]
  has_many :submission
end
