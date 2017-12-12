class Answer < ApplicationRecord
  #@body
  #@question_id
  belongs_to :question
end
