# HPG: Heroku PostgreSQL DB Helper

Automatically grabs and parses the Heroku PostgreSQL database configuration

## Why bother?
To simplify Heroku deployment, of course!

When you deploy your Rails app onto Heroku, you normally read the database configuration variables from `ENV`. For example, you might have something like this in your `config/database.yml` file:

```ruby
production:
  adapter: postgresql
  host: <%= ENV['DB_HOST'] %>
  password: <%= ENV['DB_PASSWORD'] %>
  ...
```

But in order to use this, you need to open up the Heroku Dashboard and manually set the config variables for `DB_HOST`, `DB_PASSWORD`, etc.

If you make a mistake here and forget to set a config variable, then everything will explode. If you ever change your database, then you will need to set the config variables again.

What a pain in the ass. This gem lets you bypass all that.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hpg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hpg

## Usage

Obviously, before doing anything, you should make sure your app actually has a Heroku PostgreSQL database.

### Using with Rails

Your `config/database.yml` file should have a production block similar to this:

```ruby
production:
  adapter: postgresql
  host: <%= HPG.host %>
  port: <%= HPG.port %>
  database: <%= HPG.database %>
  username: <%= HPG.user %>
  password: <%= HPG.password %>
  encoding: unicode
  pool: 20
  timeout: 3000
```

### Using without Rails

Just `require 'hpg'`, and everything should work fine!

You can use all of the built-in methods at any point in your program. For more information, check out the documentation (or `lib/hpg.rb`).


## Contributing

1. Fork it [by clicking this link](https://github.com/nealp9084/hpg/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Disclaimer

I am not affiliated with Heroku and I was not paid to make this. I am not responsible for how you use this gem. See LICENSE.txt for details.
