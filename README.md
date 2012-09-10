# Where is Ryan Bigg?

It's a question that pretty much drives society as we know it.

## Contributions welcome!  To get rolling:

Fork and clone https://github.com/wiseleyb/whereisryanbigg

```
cd whereisryanbigg
bundle install
cp config/database.yml.example config/database.yml
... modify database.yml
bundle exec rake db:nuke
```

Currently - when you change assets you need to do a super lame assets:precompile.  Heroku issue... working on it.

```
RAILS_ENV=production bundle exec rake assets:precompile
```



Site is temporarily up on http://whereisryanbigg.herokuapp.com/
