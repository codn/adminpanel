module Adminpanel
  module Analytics
    module TwitterAnalytics
      extend ActiveSupport::Concern

      included do
        before_action :get_twitter_token, only:[:twitter, :reply_to_tweet, :favorite_tweet, :retweet_tweet]
      end

      def reply_to_tweet
        @twitter_client.update params[:tweet], in_reply_to_status_id: params[:id]
        redirect_to twitter_analytics_path
      end

      def favorite_tweet
        @twitter_client.favorite(params[:id])
      end

      def retweet_tweet
        @twitter_client.retweet(params[:id])
      end

    end
  end
end
