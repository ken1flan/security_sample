class Blog < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 1000 }
  validates :user_id, presence: true
end
