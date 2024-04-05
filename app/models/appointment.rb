class Appointment < ApplicationRecord

  validates :start_time,presence: true

  belongs_to :pacient
  belongs_to :user

end
