class EnvelopesController < ApplicationController
  before_action :envelope, only: :edit
  before_action :banks, only: [:index, :new, :edit]

  def index
    @envelopes = Envelope.where(user_id: current_user.id)
  end

  def new
    @envelope = Envelope.new
  end

  def create
    @envelope = Envelope.new(envelope_params)
    if @envelope.save
      flash[:success] = 'Congratulations! Your envelope has been created!'
      redirect_to dashboard_path
    else
      flash.now[:error] = @envelope.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if envelope.update(envelope_params)
      flash[:success] = "The Envelope was updated"
      redirect_to dashboard_path
    else
      flash.now[:error] = envelope.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    envelope.destroy
    flash[:success] = "The Envelope was deleted"
    redirect_to dashboard_path
  end

  private

  def envelope_params
    params.require(:envelope).permit(:category, :total)
  end

  def envelope
    @envelope ||= Envelope.find(params[:id])
  end

  def banks
    @banks = Bank.where(user_id: current_user.id)
  end
end
