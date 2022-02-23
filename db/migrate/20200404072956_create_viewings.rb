class CreateViewings < ActiveRecord::Migration[6.0]
  def change
    create_table :viewings do |t|
      t.references :account
      t.references :property
      t.datetime :date
      t.text :notes
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
