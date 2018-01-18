class User < ApplicationRecord
    #@name
    #@email
    #@password_digest - encrypted hash in db
    #@role
    
    #@password - user input string
    #@password_confrimation - just to make user retype password
    enum role: [:member, :admin]

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy

    #before try to save and make validations
    before_save { self.role = :member if self.role.nil?}    #default value will be member unless we code otherwise
    before_save { self.email = email.downcase if email.present? }

    
    #these tests run post save/create/update
    validates :name,
    presence: true, 
    length: { minimum: 1, maximum: 100 } 

    validates :password, 
    presence: true, 
    length: { minimum: 6 }, 
    if: "password_digest.nil?" #if this attr on the user model is nil (i.e. new user) - run these validations
    
    validates :password, #validation for password update
    length: { minimum: 6 }, #if they enter someting at least 6
    allow_blank: true   #but at this stage, blank would also be allowed, because that would retain current password
    
    validates :email,
    presence: true,
    length: { minimum: 3, maximum: 254 },
    uniqueness: { case_sensitive: false }

    has_secure_password
end
