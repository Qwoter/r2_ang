class TablesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :setup_errors

  def index
    @tables = Table.all
  end

  def show
    @table = Table.find(params[:id])
  end

  def create
    @table = Table.new(params.require(:table).permit(:number))

    if !@table.save
      @errors = @table.errors.full_messages * "<br />"
      render template: 'shared/error.json.jbuilder', status: :unprocessable_entity
    else
      render 'show', status: :created
    end
  end

  def update
    @table = Table.find(params[:id])

    if !@table.update_attributes(params.require(:table).permit(:number))
      @table.reload
      @errors = @table.errors.full_messages * "<br />"
      render template: 'tables/show.json.jbuilder', status: :unprocessable_entity
    else
      head :no_content
    end
  end

  def destroy
    table = Table.find(params[:id])
    table.destroy
    head :no_content
  end

  private

  def setup_errors
    @errors = ""
  end
end
