class EnvelopesController < ApplicationController
  before_filter :envelope, only: :edit

  def index
    @envelopes = current_user.envelopes
  end

  def new
    @envelope = Envelope.new
  end

  def create
    @envelope = current_user.envelopes.build(envelope_params)
    if @envelope.save
      flash[:success] = 'Congratulations! Your envelope has been created!'
      redirect_to user_path(current_user)
    else
      flash.now[:error] = @envelope.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if envelope.update(envelope_params)
      flash[:success] = "Envelope was update"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = envelope.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    envelope.destroy
    flash[:success] = "Envelope deleted"
    redirect_to user_path(current_user)
  end

  private

  def envelope_params
    params.require(:envelope).permit(:category, :total, :bank_id)
  end

  def envelope
    @envelope ||= Envelope.find(params[:id])
  end
end
