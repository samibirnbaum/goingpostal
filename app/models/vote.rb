class Vote < ApplicationRecord
  #@value
  #@user_id
  #@post_id
  belongs_to :user
  belongs_to :post

  validates :value, 
  presence: true,
  inclusion: {in: [-1, 1], message: "%{value} is not a valid vote."}

  after_save :update_post

  private
    def update_post
      self.post.update_rank #when this method is called on the vote object, it ultimatley calls a method on the post object associated with that vote 
    end
end
