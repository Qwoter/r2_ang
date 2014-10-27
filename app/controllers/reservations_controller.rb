class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :setup_errors
  skip_before_filter :verify_authenticity_token

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render 'show', status: :created
    else
      @errors = @reservation.errors.full_messages * "<br />"
      render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      head :no_content
    else
      @errors = @reservation.errors.full_messages * "<br />"
      render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  private
    # Setup common parameters.
    def setup_errors
      @errors = ""
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      if params[:reservation].blank?
        {}
      else
        params.require(:reservation).permit(:table_id, :start_time, :end_time, :additional_info)
      end
    end
end
