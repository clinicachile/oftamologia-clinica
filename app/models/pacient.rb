class Pacient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  validates :first_name, presence: true
  accepts_nested_attributes_for :appointments

  def self.ransackable_attributes(auth_object = nil)
    ["first_name", "last_name"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["appointments"]
  end
end
