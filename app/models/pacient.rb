class Pacient < ApplicationRecord
  has_many :appointments

  accepts_nested_attributes_for :appointments
end
