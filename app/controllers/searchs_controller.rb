class SearchsController < ApplicationController
  before_action :hot_movie
  def index
    return @movies = nil if params[:m].blank?
    @pagy, @movies = pagy @search.result.sort_list, items: 9
  end
end
