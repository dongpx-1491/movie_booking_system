class SearchsController < ApplicationController
  before_action :hot_movie
  def index
    @result_number = @search.result.active.size
    @pagy, @movies = pagy @search.result.active.sort_list, items: 9
  end
end
