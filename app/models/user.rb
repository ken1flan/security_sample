class User < ApplicationRecord
  has_secure_password
  has_many :blogs
  has_one :measurement_tag

  validates :login_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@]+@[^@]+\Z/ }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :self_introduction, length: { maximum: 500 }
  validates :homepage, format: { with: /^https?:\/\/.*$/, multiline: true }, allow_blank: true
end
