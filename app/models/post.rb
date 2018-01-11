class Post < ApplicationRecord #ApplicationRecord inherits from ActiveRecord::Base, which defines a number of helpful methods for interaction with database an ORM library.
    #@title
    #@body
    belongs_to :topic
    belongs_to :user
    has_many :comments, dependent: :destroy #when a certain post is deleted all its comments are also deleted

    default_scope { order('created_at DESC') }

    validates(:title, presence: true, length: {minimum: 5})
    validates(:body, presence: true, length: {minimum: 20})
    validates(:topic, presence: true)
    validates(:user, presence: true) #cant be nil baby
end
