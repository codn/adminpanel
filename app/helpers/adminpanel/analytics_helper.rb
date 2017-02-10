module Adminpanel
  module AnalyticsHelper

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

    def insight
      return 'day' if !params[:insight].present?
      return 'day' if params[:insight] == 'day'
      return 'week' if params[:insight] == 'week'
      return 'month' if params[:insight] == 'days_28'
    end

    def metric(metric)
      metric.first['name']
    end

    def fb_insights(fb_auth)
      if fb_auth
        "#{Koala::Facebook::API.new(fb_auth.value).get_object('me')['link']}insights"
      else
        '#'
      end
    end

    def exist_instagram_account?
      if @instagram_token.nil?
        false
      else
        true
      end
    end
  end
end
