class Post < ApplicationRecord #ApplicationRecord inherits from ActiveRecord::Base, which defines a number of helpful methods for interaction with database an ORM library.
    #@title
    #@body
    belongs_to :topic
    has_many :comments, dependent: :destroy #when a certain post is deleted all its comments are also deleted
end
