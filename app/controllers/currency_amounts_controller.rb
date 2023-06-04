# app/controllers/currency_amounts_controller.rb

class CurrencyAmountsController < ApplicationController
  before_action :set_wallet

  def create
    @currency_amount = @wallet.currency_amounts.build(currency_amount_params)

    respond_to do |format|
      if @currency_amount.save
        format.html { redirect_to @wallet }
        format.js
      else
        format.html { render 'wallets/show' }
        format.js { render partial: 'shared/errors', locals: { object: @currency_amount } }
      end
    end
  end

  def destroy
    @currency_amount = @wallet.currency_amounts.find(params[:id])
    @currency_amount.destroy

    respond_to do |format|
      format.html { redirect_to @wallet }
      format.js
    end
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  def currency_amount_params
    params.require(:currency_amount).permit(:currency, :amount)
  end
end
