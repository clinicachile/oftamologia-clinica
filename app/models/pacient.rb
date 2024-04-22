class Pacient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name]
  end

  def self.ransackable_associations(auth_object = nil)
    ['appointments']
  end
end
