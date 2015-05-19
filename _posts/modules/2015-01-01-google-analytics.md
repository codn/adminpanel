---
title: Google Analytics
category: module
---

To take advantage of the Integration with the Google Analytics Service you should add the analytics script to the public side of your application and then create an intializer called when you setup your authentication with Google.

* `config.analytics_account_email` : Your account email (you can create a new one just for this purpose...)
* `config.analytics_profile_id` : your account id (same advice)
* `config.analytics_key_filename` : your certificate file, make sure you don't share this secret file.
* `config.analytics_key_path` : The directory where the key file is make sure it's the path, example: config/analytics

Currently it only shows the visits from the last week, but more integrations will come.

For more information about using the Google API visit

* [Google Analytics API](https://developers.google.com/analytics/devguides/reporting/core/v3/)
* [Google API Ruby Client](https://github.com/google/google-api-ruby-client)
* [Google OAuth 2.0](https://developers.google.com/accounts/docs/OAuth2)
* [Google Developers Console](https://cloud.google.com/console)
* [id](https://developers.google.com/analytics/devguides/config/mgmt/v3/mgmtReference/management/accountSummaries/list)
