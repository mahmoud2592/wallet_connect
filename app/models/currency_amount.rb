class CurrencyAmount < ApplicationRecord
  belongs_to :wallet
  belongs_to :currency
end
