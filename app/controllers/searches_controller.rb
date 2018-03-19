class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @query = params[:query]
    @result = @model == 'All' ? ThinkingSphinx.search(@query) : @model.constantize.search(@query)
  end
end
