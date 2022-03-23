require 'carrierwave/orm/activerecord'

class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :file, :job_id
end
