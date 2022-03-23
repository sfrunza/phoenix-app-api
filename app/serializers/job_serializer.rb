class JobSerializer < ActiveModel::Serializer
  attributes :id,
            :customer,
            :pick_up_date,
            :delivery_date,
            :is_flat_rate,
            :is_confirmed_by_customer,
            :is_confirmed_by_manager,
            :storage_fee,
            :deposit,
            :is_deposit_paid,
            :start_time,
            :job_status,
            :job_size,
            :job_type,
            :crew_size,
            :job_rate,
            :estimated_time,
            :travel_time,
            :time_between,
            :estimated_quote,
            :additional_info,
            :job_duration,
            :total_amount,
            :created_at,
            :updated_at,
            :images,
            :receipt,
            :addresses
  has_many :users
  # has_many :addresses
  has_many :images
end
              