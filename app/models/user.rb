class User < ApplicationRecord
  # self keyword is referring to the User object, so all emails belonging to User object will be downcased
  before_save { self.email = email.downcase }

  # dependent: :destroy will destroy all the articles if the user is deleted
  has_many :articles, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username,
            presence: true,
            length: { minimum: 3, maximum: 25 },
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end
