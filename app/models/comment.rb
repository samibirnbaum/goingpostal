class Comment < ApplicationRecord
  #@body
  #@post_id
  belongs_to :post #method for every comment `.post` - when retrieve a comment from the db can get the associated post using this method
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
