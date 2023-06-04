class CreateCurrencyAmounts < ActiveRecord::Migration[6.1]
  def change
    create_table :currency_amounts do |t|
      t.references :wallet, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
