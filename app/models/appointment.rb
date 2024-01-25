class Appointment < ApplicationRecord
  belongs_to :pacient
  belongs_to :user

end
