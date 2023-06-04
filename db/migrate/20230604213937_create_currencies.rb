class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :address
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
