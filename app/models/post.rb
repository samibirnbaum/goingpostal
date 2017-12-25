class Post < ApplicationRecord #ApplicationRecord inherits from ActiveRecord::Base, which defines a number of helpful methods for interaction with database an ORM library.
    #@title
    #@body
    has_many :comments, dependent: :destroy #provides a comments method for every instance of Post which is a getter/setter for comments associated with the post
end
