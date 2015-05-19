---
title: Custom Errors
category: generator
---
This generator let you create custom error pages (404, 500 and so on). Generates `ErrorsController` and `errors#show`, You  may use your default app layout or create a less complex layout.

Note: In order to test custom errors you'll have to set `config.consider_all_requests_local       = true` in `config/development.rb` and restart your server.
