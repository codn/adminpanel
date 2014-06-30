module Adminpanel
  module TwitterAnalytics

    extend ActiveSupport::Concern

    included do
      # before_filter :set_twitter_tokens, only:[:twitter, :reply_to_tweet, :favorite_tweet, :retweet_tweet]
      before_filter :set_twitter_token, only:[:twitter, :reply_to_tweet, :favorite_tweet, :retweet_tweet]
    end

    def reply_to_tweet

      @twitter_client.update params[:tweet], in_reply_to_status_id: params[:id]

      render 'twitter'
    end

    def favorite_tweet
      @twitter_client.favorite(params[:id])
    end

    def retweet_tweet
      @twitter_client.retweet(params[:id])
    end

  private
    def set_twitter_token
      @twitter_token = Auth.find_by_key 'twitter-token'
      @twitter_secret = Auth.find_by_key 'twitter-secret'

      if !@twitter_token.nil? && !@twitter_secret.nil?
        @twitter_client ||= ::Twitter::REST::Client.new do |config|
          config.consumer_key        = Adminpanel.twitter_api_key
          config.consumer_secret     = Adminpanel.twitter_api_secret
          config.access_token        = @twitter_token.value
          config.access_token_secret = @twitter_secret.value
        end
      end
    end

  end
end
