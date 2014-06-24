module Adminpanel
  module AnalyticsHelper
  def first_fb_value(metric)
      total = 0.0
      # metric.first['values'].each do |value|
      #   if value['value'] != []
      #     total = total + value['value'].to_f
      #   end
      # end
      # return total
      metric.first['values'].last['value'].to_f
    end

    def days_to_substract
      if params[:insight] == 'day'
        1
      elsif params[:insight] == 'week'
        7
      elsif params[:insight] == 'days_28'
        28
      else
        0
      end
    end

    def divide_metrics(metric_1, metric_2)
      if first_fb_value(metric_2) != 0.0
        return first_fb_value(metric_1) / first_fb_value(metric_2)
      else
        return 0
      end
    end

    def insight
      return 'day' if !params[:insight].present?
      return 'day' if params[:insight] == 'day'
      return 'week' if params[:insight] == 'week'
      return 'month' if params[:insight] == 'days_28'
    end

    def metric(metric)
      metric.first['name']
    end

    def tweet_link(tweet)
      "http://www.twitter.com/#{tweet.user.username}/status/#{tweet.id}"
    end
  end
end
