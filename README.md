# 6.170 Project 2

TeamNote, a persistent collaborative note-taking application.

+ Full Name: Stephen Suen
+ Github Tree URL: https://github.com/6170-fa13/ssuen_proj2/tree/29f554832ff61d4baf449519aea34c671f413bba
+ Heroku URL: http://ssuen-teamnote.herokuapp.com/

## Setup

To run this app on your local machine:
+ `git clone` - download this repository
+ `bundle install` - install relevant rubygems
+ `rake db:migrate` - set up database
+ `rails s` - start server (defaults to http://0.0.0.0:3000)
+ (optional) in `rails c` run `Note.generate` to quickly populate the database with entries

To run this app in the browser, simply visit the [Heroku-hosted instance](http://ssuen-teamnote.herokuapp.com), where some notes have already been created.
