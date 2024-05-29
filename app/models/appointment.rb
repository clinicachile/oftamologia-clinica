class Appointment < ApplicationRecord
  validates :start_time, presence: true
  validates :description, presence: true
  validates :price, presence: true
  enum status: { pending: 1, confirmation: 2, canceled: 3, completed: 4 }
  belongs_to :pacient
  belongs_to :user
end
