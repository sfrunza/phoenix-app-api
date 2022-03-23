require 'carrierwave/orm/activerecord'

class Receipt < ActiveRecord::Base
    mount_uploader :file, PhotoUploader
    belongs_to :job, :optional => true
end
