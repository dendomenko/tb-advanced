class TagsController < ApplicationController
  def show
    @tags = Question.tag_counts.order(taggings_count: :desc)
  end
end