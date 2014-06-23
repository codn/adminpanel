module Adminpanel
  module TwitterActions
    extend ActiveSupport::Concern

    included do
      before_filter :set_twitter_auths_count, only:[:index, :create, :update, :destroy, :show]
    end

    def twitter_publish
      token = Auth.find_by_key('twitter-token')
      secret = Auth.find_by_key('twitter-secret')
      resource.twitter_message = params[model_name][:twitter_message]
      if !token.nil? && !secret.nil? && resource.has_valid_tweet?
        client = ::Twitter::REST::Client.new do |config|
          config.consumer_key = Adminpanel.twitter_api_key
          config.consumer_secret = Adminpanel.twitter_api_secret
          config.access_token = token.value
          config.access_token_secret = secret.value
        end
        # debugger
        client.update(resource.twitter_message)
        flash[:success] = I18n.t('twitter.posted', user: token.name)
        redirect_to resource
      end
    end

  private
    def set_twitter_auths_count
      @twitter_token = Auth.find_by_key 'twitter-token'
      @twitter_secret = Auth.find_by_key 'twitter-secret'
    end

    def model_name
      @model.name.demodulize.downcase # ex: posts
    end
  end
end
