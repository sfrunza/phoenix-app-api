class AddressSerializer < ActiveModel::Serializer
    attributes :id, :job_id, :address, :city, :state, :zip, :apt_number, :floor, :is_origin, :is_destination, :is_pickup, :is_dropoff
  
  end
  