class Address < ApplicationRecord
    belongs_to :job, :optional => true
  end