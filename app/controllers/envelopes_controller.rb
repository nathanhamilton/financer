class EnvelopesController < ApplicationController
  before_action :envelope, only: :edit
  before_action :banks, only: [:new, :index, :edit]

  def index
    @envelopes = current_user.envelopes
  end

  def new
    @envelope = Envelope.new
  end

  def create
    @envelope = current_user.envelopes.new(envelope_params)
    if @envelope.save
      flash[:success] = 'Congratulations! Your envelope has been created!'
      redirect_to root_path
    else
      flash.now[:error] = @envelope.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if envelope.update(envelope_params)
      flash[:success] = "Envelope was update"
      redirect_to root_path
    else
      flash.now[:error] = envelope.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    envelope.destroy
    flash[:success] = "Envelope deleted"
    redirect_to root_path
  end

  private

  def envelope_params
    params.require(:envelope).permit(:category, :total, :bank_id)
  end

  def envelope
    @envelope ||= Envelope.find(params[:id])
  end

  def banks
    @banks ||= current_user.banks
  end
end
