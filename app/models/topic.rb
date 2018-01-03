class Topic < ApplicationRecord
    #@name
    #@description
    #@public
    has_many :posts, dependent: :destroy #when call destroy on topic also call it on all its posts

    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :public

    validates_length_of :name, minimum: 5
    validates_length_of :description, minimum: 15
end
