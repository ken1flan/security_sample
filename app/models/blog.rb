class Blog < ApplicationRecord
  belongs_to :user

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 1000 }
  validates :user_id, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
