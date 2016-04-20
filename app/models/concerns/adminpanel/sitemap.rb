module Adminpanel
  module Sitemap
    extend ActiveSupport::Concern

    included do
      after_create :ping_engines
      after_update :ping_engines
      after_destroy :ping_engines
    end

  private
    def ping_urls
      {
        google: "http://www.google.com/webmasters/tools/ping?sitemap=%s",
        bing: "http://www.bing.com/webmaster/ping.aspx?siteMap=%s"
      }
    end

    def ping_engines
      ping_urls.each do |name, url|
        request = url % CGI.escape("#{Rails.application.routes.url_helpers.root_url}/sitemap.xml")
        logger.info "  Pinging #{name} with #{request}"
        if Rails.env.production?
          response = Net::HTTP.get_response(URI.parse(request))
          logger.info "    #{response.code}: #{response.message}"
          logger.info "    Body: #{response.body}"
        end
      end
    end

  end
end
