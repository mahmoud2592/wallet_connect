class SavedEntriesController < ApplicationController
  def create
    @wallet = Wallet.find(params[:wallet_id])
    @saved_entry = @wallet.saved_entries.build(saved_entry_params)

    if @saved_entry.save
      redirect_to @wallet
    else
      render 'wallets/show'
    end
  end

  def destroy
    @saved_entry = SavedEntry.find(params[:id])
    @wallet = @saved_entry.wallet

    if @saved_entry.destroy
      redirect_to @wallet
    else
      render 'wallets/show'
    end
  end

  private

  def saved_entry_params
    params.require(:saved_entry).permit(:wallet_address, :amount)
  end
end
