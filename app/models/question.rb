class Question < ApplicationRecord
    #@title
    #@body
    #@resolved
    has_many :answers
end
