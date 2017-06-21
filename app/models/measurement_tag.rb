class MeasurementTag < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :body, presence: true, length: { maximum: 500 }
end
