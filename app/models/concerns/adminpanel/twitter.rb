module Adminpanel
  module Twitter
    extend ActiveSupport::Concern
    included do
      attr_accessor :twitter_message
    end

    def share_link
      'http://www.google.com'
    end

    def has_valid_tweet?
      if self.twitter_message.length <= 140
        true
      else
        false
      end
    end

    # static(class) methods
    module ClassMethods
      def twitter_share?
        true
      end
    end
  end
end
