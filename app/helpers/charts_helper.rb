module ChartsHelper
  def top_movies_seller_chart
    column_chart top_movies_seller_charts_path, height: '500px', xtitle: t("movie_chart"), ytitle: t("booked_number"), empty: "No data", refresh: 60, stacked: true, thousands: ",", suffix: "VND"
  end

  def top_movies_booking_chart
    pie_chart top_movies_booking_charts_path, height: '500px', xtitle: t("movie_chart"), ytitle: t("booked_number"),donut: true
  end

  def revenue_by_day_chart
    area_chart revenue_by_day_charts_path, height: '500px', empty: "No data", refresh: 60, stacked: true, thousands: ",", suffix: "VND"
  end
end
