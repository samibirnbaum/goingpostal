class Comment < ApplicationRecord
  #@body
  #@post_id
  #@user_id
  belongs_to :post 
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails

  private
    def send_favorite_emails
      self.post.favorites.each do |favorite|
        FavoriteMailer.new_comment(favorite.user, self.post, self).deliver_now
      end
    end
end
