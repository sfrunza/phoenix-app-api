class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.string :file
      t.belongs_to :job, index: true
    end
  end
end
