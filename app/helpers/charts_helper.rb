module ChartsHelper
  def top_movies_seller_chart
    pie_chart top_movies_seller_charts_path
  end

  def top_movies_booking_chart
    pie_chart top_movies_booking_charts_path
  end
end
