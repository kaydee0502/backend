# frozen_string_literal: true

class Content < ApplicationRecord
  enum data_type: %i[question video article topic subtopic]
  enum difficulty: %i[easy medium hard]
  enum question_type: %i[class assignment]
  has_many :submission


  def self.split_by_difficulty
    questions = Content.all.pluck(:difficulty)
    bydiffs = Hash["easy" => 0,"medium" => 0,"hard" => 0]

    for q in questions do
     
      if q == "easy" then
        bydiffs["easy"] += 1

      elsif q == "medium" then
        bydiffs["medium"] += 1

      elsif q == "hard" then
        bydiffs["hard"] += 1

      end
     

    end
    bydiffs

  end
end
