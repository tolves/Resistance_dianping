# README

This app uses [telegram-bot](https://github.com/telegram-bot-rb/telegram-bot) gem.

Deployment steps:

1. set telegram bot token in credentials:

``` EDITOR=vim bin/rails credentials:edit ```
```
telegram:
  bot:
    token: #token
    username: #botname
```

2. Deploy to Heroku:

* set config DATABASE_URL

* set config RAILS_MASTER_KEY

* set config URL = heroku URL

* heroku run command:

  - migrate database schemas:

  ``` rails db:migrate ```

  - create all the default record

  ``` rails db:seed ```

  - setup webhook

  ``` bin/rake telegram:bot:set_webhook RAILS_ENV=production ```

TODO: add a new model: statistics, string:keywords, integer: view_count
