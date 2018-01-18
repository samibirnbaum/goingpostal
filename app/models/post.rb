class Post < ApplicationRecord #ApplicationRecord inherits from ActiveRecord::Base, which defines a number of helpful methods for interaction with database an ORM library.
    #@title
    #@body
    #@topic_id
    #@post_id
    
    belongs_to :topic
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy

    default_scope { order('created_at DESC') }

    validates(:title, presence: true, length: {minimum: 5})
    validates(:body, presence: true, length: {minimum: 20})
    validates(:topic, presence: true)
    validates(:user, presence: true)

    def up_votes
        self.votes.where(value: 1).count    #self is the object this method will exist on
    end

    def down_votes
        self.votes.where(value: -1).count
    end

    def points
        up_votes = self.votes.where(value: 1).count
        down_votes = self.votes.where(value: -1).count
        up_votes - down_votes     
    end
end
