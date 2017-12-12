class Post < ApplicationRecord #ApplicationRecord inherits from ActiveRecord::Base, which defines a number of helpful methods for interaction with database.
    #@title
    #@body
    has_many :comments #ARMethod-allows post object to have many comment onbjects related to it + creates some cool methods for us, like (attr_accessor :attribute) dynamically creates getter and setter methods
end
