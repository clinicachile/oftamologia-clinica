class Pacient < ApplicationRecord
  has_many :appointments
  validates :first_name, presence: true
  accepts_nested_attributes_for :appointments
end
