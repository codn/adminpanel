module Adminpanel
  module TweetActions
    extend ActiveSupport::Concern


    def reply_to_tweet

      @client.update params[:tweet], in_reply_to_status_id: params[:id]

      render 'twitter'
    end

    def favorite_tweet
      @client.favorite(params[:id])
    end

    def retweet_tweet
      @client.retweet(params[:id])
    end
  end
end
