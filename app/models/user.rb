class User < ActiveRecord::Base
  # before email is saved make sure lowercase
  before_save { self.email = email.downcase }
  
  # Some nice rules
  validates :screenname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  # Lets make rails handle the user security
  has_secure_password
end
