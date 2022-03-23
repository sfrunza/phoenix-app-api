class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :floor
      t.string :apt_number
      t.boolean :is_origin, default: false
      t.boolean :is_destination, default: false
      t.boolean :is_pickup, default: false
      t.boolean :is_dropoff, default: false
      t.belongs_to :job, index: true

      t.timestamps
    end
  end
end
