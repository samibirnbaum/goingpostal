class Comment < ApplicationRecord
  #@body
  #@post_id
  belongs_to :post #method for every comment `.post` - when retrieve a comment from the db can get the associated post using this method
end
