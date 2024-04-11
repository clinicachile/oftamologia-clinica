class Pacient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  validates :first_name, presence: true
  accepts_nested_attributes_for :appointments
end
