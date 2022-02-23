class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :account_1, references: :accounts
      t.references :account_2, references: :accounts
      t.string :match_type
      t.timestamps
    end
  end
end
