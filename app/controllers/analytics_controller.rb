# Display search history analytics
class AnalyticsController < ApplicationController
  def index
    trends
    ips
    top_searches
    top_search_results_within_week
    search_timeline
  end

  private

  def trend_time_range
    Time.current.all_day
  end

  def top_search_time_range
    1.week.ago.beginning_of_day..Time.current
  end

  def trends
    @trends ||= SearchHistory.where(updated_at: trend_time_range).group(:term).order('count_all desc').limit(10).count
  end

  def ips
    @ips ||= SearchHistory.where(updated_at: top_search_time_range).group(:ip).order('count_all desc').limit(10).count
  end

  def top_searches
    @top_searches ||= SearchHistory.where(updated_at: top_search_time_range)
                                   .group(:term).order('count_all desc').limit(20).count
  end

  def top_search_results_within_week
    @top_search_results_within_week ||= SearchHistory.group(:term).order('maximum_result_count desc')
                                                     .limit(10).maximum(:result_count)
  end

  def search_timeline
    @search_timeline ||= SearchHistory.group_by_hour(:updated_at).count
  end
end
