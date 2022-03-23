class AddDepositToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :deposit, :integer
    add_column :jobs, :is_deposit_paid, :boolean, null: false, default: false
  end
end
