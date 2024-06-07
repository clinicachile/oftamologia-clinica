class Pacient < ApplicationRecord
  validates :first_name, :last_name, :phone, :email, presence: true

  has_many :appointments, dependent: :destroy

  accepts_nested_attributes_for :appointments

  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name]
  end

  def self.ransackable_associations(auth_object = nil)
    ['appointments']
  end
end
