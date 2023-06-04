class Wallet < ApplicationRecord
  has_many :currency_amounts
  has_many :saved_entries
end
