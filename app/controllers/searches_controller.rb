class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @query = params[:query]
    @result = @model == 'All' ? Searchkick.search(@query, index_name: [Answer, Question, Comment, User]) : @model.constantize.search(@query)
  end
end