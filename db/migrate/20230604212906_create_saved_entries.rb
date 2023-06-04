class CreateSavedEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_entries do |t|
      t.string :wallet_address
      t.integer :amount

      t.timestamps
    end
  end
end
