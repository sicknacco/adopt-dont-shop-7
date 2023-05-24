class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, :street_address, :city, :state, :description, :status, presence: true
  validates :zip_code, presence: true, length: { is: 5 }
end