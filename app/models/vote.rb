class Vote < ApplicationRecord
  #@value
  #@user_id
  #@post_id
  belongs_to :user
  belongs_to :post

  validates :value, 
  presence: true,
  inclusion: {in: [-1, 1], message: "%{value} is not a valid vote."}

end
