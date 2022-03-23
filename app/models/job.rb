class Job < ApplicationRecord
  belongs_to :customer
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users
  has_many :addresses 
  accepts_nested_attributes_for :addresses 
  has_many :images, dependent: :destroy
  has_one :receipt, dependent: :destroy
end
