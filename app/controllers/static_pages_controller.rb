class StaticPagesController < ApplicationController
  before_action :hot_movie

  def home
    @categories = Category.all
  end
end
