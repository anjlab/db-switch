# Db Switch

[![Build Status](https://travis-ci.org/anjlab/db-switch.svg?branch=master)](https://travis-ci.org/anjlab/db-switch)

This is a Rails 5 gem which allows you to use different database connections in your projects

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'db-switch'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install db-switch

## Usage

**First**, you need to define your databases. In Rails, you define databases in `database.yml`. This is also the place where you can add your custom connections:

```yaml
development:
  adapter: postgresql
  database: dev_database
  host: localhost
  pool: 5

test:
  adapter: sqlite3
  database: test_db_1.sqlite3
  pool: 5

replica_one:
  development:
    adapter: postgresql
    database: dev_replica
    host: localhost
    pool: 5

  test:
    adapter: sqlite3
    database: test_db_2.sqlite3
    pool: 5
```

In the above sample we have defined `replica_one` alternative database connection, for both development and test environments.

**Second**, specify connection in your code:

```ruby
ActiveRecord::Base.connect_to(:replica_one) do
  @products = Product.where('created_at > ?', 1.day.ago).to_a
end

# or somewhere inside your ActiveRecord model

def load_products
  connect_to(:replica_one) do
    Product.where('created_at > ?', 1.day.ago).to_a
  end  
end

```

This will query data from the `replica_one` database specified above.

**That's it! Use it!**

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

