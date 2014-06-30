module Adminpanel
  class AnalyticsController < Adminpanel::ApplicationController
    include Adminpanel::TwitterAnalytics
    include Adminpanel::InstagramAnalytics

    skip_authorization_check
    skip_before_filter :set_model

    API_VERSION = 'v3'
    CACHED_API_FILE = "#{Rails.root}/tmp/cache/analytics-#{API_VERSION}.cache"

    def index
      unless Adminpanel.analytics_profile_id.nil? || Adminpanel.analytics_key_filename.nil?
        service_account_email = '266789642405-0nppij5ll43bbvhpsn986puulssdoc45@developer.gserviceaccount.com' # Email of service account
        key_file = "#{Rails.root}/#{Adminpanel.analytics_key_path}/#{Adminpanel.analytics_key_filename}" # File containing your private key
        key_secret = 'notasecret' # Password to unlock private key
        profileID = Adminpanel.analytics_profile_id # Analytics profile ID.


        client = Google::APIClient.new(
          :application_name => 'AdminPanel',
          :application_version => '1.0.0'
        )

        analytics = nil
        # Load cached discovered API, if it exists. This prevents retrieving the
        # discovery document on every run, saving a round-trip to the discovery service.
        if File.exists? CACHED_API_FILE
          File.open(CACHED_API_FILE) do |file|
            analytics = Marshal.load(file)
          end
        else
          analytics = client.discovered_api('analytics', API_VERSION)
          File.open(CACHED_API_FILE, 'w') do |file|
            Marshal.dump(analytics, file)
          end
        end

        key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)
        client.authorization = Signet::OAuth2::Client.new(
          :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
          :audience => 'https://accounts.google.com/o/oauth2/token',
          :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
          :scope => 'https://www.googleapis.com/auth/analytics.readonly',
          :issuer => service_account_email,
          :signing_key => key
        )
        # Request a token for our service account
        client.authorization.fetch_access_token!

        startDate = DateTime.now.prev_month.strftime("%Y-%m-%d")
        endDate = DateTime.now.strftime("%Y-%m-%d")

        @visitCount = client.execute(
          :api_method => analytics.data.ga.get,
          :parameters => {
            'ids' => "ga:#{profileID}",
            'start-date' => startDate,
            'end-date' => endDate,
            'dimensions' => "ga:day,ga:month",
            'metrics' => "ga:visits",
            'sort' => "ga:month,ga:day"
          }
        )

        @visits = @visitCount.data.rows.collect do |r|
        	r[2]
        end

        @visitDates = @visitCount.data.rows.collect { |r| "#{r[0]}/#{r[1]}" }

      end
      respond_to do |format|
        format.html
        format.json {render :json => {:visit_count => @visitCount, :visits => @visits, :visit_dates => @visitDates }}
      end
    end

    def fb
      auth = Adminpanel::Auth.find_by_key('facebook')
      if params[:insight].present?
        period = params[:insight]
      else
        period = 'day' #default period
      end
      if !auth.nil? && auth.value != '' # not nil & not void
        page_graph = Koala::Facebook::API.new(Auth.find_by_key('facebook').value)
        @impressions,
        @impressions_unique,

        @new_likes,
        @total_likes,

        @hidden,
        @hidden_unique,

        @consumptions,
        @consumptions_unique,

        @views,
        @views_unique,

        @stories = page_graph.batch do |api|
          #all information on same request
          api.get_connections('me', 'insights', metric: 'page_impressions', period: period) #eye
          api.get_connections('me', 'insights', metric: 'page_impressions_unique', period: period) #eye

          api.get_connections('me', 'insights', metric: 'page_fan_adds') #fb-thumb
          api.get_connections('me', 'insights', metric: 'page_fans') #fb-thumb

          api.get_connections('me', 'insights', metric: 'page_negative_feedback', period: period)
          api.get_connections('me', 'insights', metric: 'page_negative_feedback_unique', period: period)

          api.get_connections('me', 'insights', metric: 'page_consumptions', period: period)
          api.get_connections('me', 'insights', metric: 'page_consumptions_unique', period: period)

          api.get_connections('me', 'insights', metric: 'page_views')
          api.get_connections('me', 'insights', metric: 'page_views_unique')

          api.get_connections('me', 'insights', metric: 'page_stories', period: period)
        end
      end
    end

    # uses @client to fetch replies and tweets, for some statics

    def twitter
      if !@twitter_token.nil? && !@twitter_secret.nil?
        @favorites = 0.0
        @retweets = 0.0
        @twitter_user = @twitter_client.user

        # 20 is the number that we're using to measure statics.
        @twitter_client.user_timeline(@twitter_user.username).take(20).collect do |tweet|
          @favorites = @favorites + tweet.favorite_count.to_f
          @retweets = @retweets + tweet.retweet_count.to_f
        end

        @tweets = @twitter_client.mentions_timeline.take(5)

        @favorites = @favorites / 20.0
        @retweets = @retweets / 20.0
      end
    end

    def instagram
      if !@instagram_token.nil?
        @user = @instagram_client.user
      end
    end

  end
end
