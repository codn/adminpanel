module Adminpanel
  module TwitterActions
    extend ActiveSupport::Concern

    included do
      before_filter :get_twitter_token, only:[:index, :create, :update, :destroy, :show, :twitter_publish]
    end

    def twitter_publish
      resource.twitter_message = params[model_name][:twitter_message]
      if !@twitter_token.nil? && !@twitter_secret.nil? && resource.has_valid_tweet?
        client = get_twitter_token
        client.update(resource.twitter_message)
        flash[:success] = I18n.t('twitter.posted', user: @twitter_token.name)
      else
        flash[:error] = I18n.t('twitter.not-posted')
      end
      redirect_to resource
    end

  private
    def get_twitter_token
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

    def model_name
      @model.name.demodulize.downcase # ex: posts
    end
  end
end
