class TablesController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :setup_errors
  skip_before_filter :verify_authenticity_token

  def index
    @tables = Table.all
  end

  def show
  end

  def create
    @table = Table.new(reservation_params)

    if @table.save
      render 'show', status: :created
    else
      @errors = @table.errors.full_messages * "<br />"
      render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
    end
  end

  def update
    if @table.update_attributes(reservation_params)
      head :no_content
    else
      @table.reload
      @errors = @table.errors.full_messages * "<br />"
      render template: 'tables/show.json.jbuilder', status: :unprocessable_entity
    end
  end

  def destroy
    table.destroy
    head :no_content
  end

  private
    # Setup common parameters.
    def setup_errors
      @errors = ""
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @table = Table.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      if params[:table].blank?
        {}
      else
        params.require(:table).permit(:number)
      end
    end
end
