class User < ActiveRecord::Base

  before_save {self.email = email.downcase}
  before_save {self.name = (name.split.map { |e| e.capitalize}).join(" ")}

  NAME_REGEX = /([A-Z]\w+) ([A-Z]\w+)/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: {minimum: 1, maximum: 100}, presence: true
  validates :password_digest, presence: true, length: {minimum: 6}, if: "password_digest.nil?"
  validates :password_digest, length: {minimum: 6}, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 100},
            format: {with: EMAIL_REGEX}

  has_secure_password
end
