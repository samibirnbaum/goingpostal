class Topic < ApplicationRecord
    #@name
    #@description
    #@public
    has_many :posts, dependent: :destroy #when call destroy on topic also call it on all its posts
end
