# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  include TicketsHelper
  include PaymentsHelper
  include ChartsHelper
  include MoviesHelper

  before_action :set_locale, :ransack_movie

  rescue_from ActiveRecord::DeleteRestrictionError, with: :error_del_method
  def error_del_method
    flash[:danger] = t "not_del"
    redirect_to root_path
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def store_show_time_url
    session[:show_time_url] = request.original_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "text.danger"
    respond_to do |format|
      format.html{redirect_to login_path}
      format.js{render js: "window.location = '#{login_path}'"}
    end
  end

  def ransack_movie
    @search = Movie.ransack(params[:m])
  end

  def hot_movie
    @hot_movies = Movie.active.sort_by {|m| - m.tickets.size}.take 5
    @banner_movies = Movie.active.sort_by {|m| - m.tickets.size}.take 3
  end
end
