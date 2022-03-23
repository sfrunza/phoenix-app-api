require 'carrierwave/orm/activerecord'

class Gallery < ActiveRecord::Base
    mount_uploader :item, PhotoUploader
end
