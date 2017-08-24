class QueriesController < ApplicationController
  before_action :set_query, only: [:show]

  def index
    @queries = Query.all.order(created_at: :desc)
  end

  def new
    @query = Query.new
  end

  def create
    @query_object = Query.new(query_params)
    @query_object.name = "#{@query_object.source} #{@query_object.location}"

    results = @query_object.query

    if @query_object.save
      flash[:notice] = "Query created."
      redirect_to queries_path
    else
      render :action => :new
    end
  end

  def show
    @results = @query.results
  end

  private

  def query_params
    params.require(:query).permit(:source, :location)
  end

  def set_query
    @query = Query.find(params[:id])
  end
end
