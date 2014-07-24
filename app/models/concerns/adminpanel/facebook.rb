module Adminpanel
  module Facebook
    extend ActiveSupport::Concern
    included do
      attr_accessor :fb_page_access_key, :fb_message
    end

    def share_link
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
