class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :edit, :update, :destroy]

  def connect_to_wallet
    provider = Web3::Provider.new(:metamask)

    # Add the necessary logic to connect the user's wallet
    if provider.connected?
      # The wallet is already connected
      flash[:notice] = "Wallet already connected"
      redirect_to @wallet
    else
      # Prompt the user to connect their MetaMask wallet
      begin
        provider.enable
        flash[:notice] = "Wallet connected successfully"
        redirect_to @wallet
      rescue Web3::ProviderError => e
        flash[:error] = "Failed to connect wallet: #{e.message}"
        redirect_to root_path
      end
    end
  end

  def show
    @currency_amount = @wallet.currency_amounts.build
    @saved_entries = SavedEntry.all
  end

  def create
    @wallet = Wallet.new(wallet_params)

    if @wallet.save
      redirect_to @wallet
    else
      render :new
    end
  end

  def destroy
    @wallet.destroy
    redirect_to wallets_url
  end

  def save_entry
    @saved_entry = SavedEntry.new(saved_entry_params)

    if @saved_entry.save
      broadcast_saved_entry(@saved_entry)
      head :ok
    else
      render json: @saved_entry.errors, status: :unprocessable_entity
    end
  end

  def delete_entry
    SavedEntry.find(params[:id]).destroy
    head :ok
  end

  def index
    @currencies = Currency.all
  end

  def add_currency
    currency = Currency.create(currency_params)

    if currency.persisted?
      render json: { id: currency.id, address: currency.address, amount: currency.amount }
    else
      render json: { error: currency.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def delete_currency
    Currency.find(params[:id]).destroy
    render json: { success: true }
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end

  def wallet_params
    params.require(:wallet).permit(:name, :description)
  end

  def saved_entry_params
    params.require(:saved_entry).permit(:wallet_address, :amount)
  end

  def broadcast_saved_entry(saved_entry)
    ActionCable.server.broadcast('wallet_channel', saved_entry: render_saved_entry(saved_entry))
  end

  def render_saved_entry(saved_entry)
    ApplicationController.renderer.render(partial: 'saved_entries/saved_entry', locals: { saved_entry: saved_entry })
  end

  def currency_params
    params.permit(:address, :amount)
  end
end
