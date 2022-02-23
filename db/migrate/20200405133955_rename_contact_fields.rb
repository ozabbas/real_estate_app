class RenameContactFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :contacts, :account_1_id, :account_1
    rename_column :contacts, :account_2_id, :account_2
  end
end
