module Adminpanel
  module Facebook
    extend ActiveSupport::Concern
    included do
      attr_accessor :fb_page_access_key, :fb_message
    end

    #instance methods
    # def get_oauth_link
    #   Koala::Facebook::OAuth.new(
    #     Adminpanel.fb_app_id,
    #     Adminpanel.fb_app_secret,
    #   )
    # end
    def fb_link
      'http://www.google.com'
    end

    # static(class) methods
    module ClassMethods
      def fb_share?
        true
      end

    end
  end
end
