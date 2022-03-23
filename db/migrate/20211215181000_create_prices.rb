class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.integer :two_men, array: true, default: []
      t.integer :three_men, array: true, default: []
      t.integer :four_men, array: true, default: []
      t.integer :add_men, array: true, default: []
      t.integer :add_truck, array: true, default: []

      t.timestamps
    end
  end
end
