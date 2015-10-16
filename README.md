# Bbr

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/bbr`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bbr'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bbr

## Usage

### ENVIRONMENT VARIABLES
in initializer
```ruby
BBR.username = ENV['BBR_USERNAME']
BBR.password = ENV['BBR_PASSWORD']
```
Contact Nicolai or Jesper for credentials if you are a member of the Abtion Team

```ruby
BBR.building_data_from_address("Danas Plads 17, 1915 Frederiksberg")
=> {:building=>{:age=>98, :area=>"427", :floors=>"6", :roof=>{:material=>"Tegl", :area=>"0"}, :heating=>{:installation=>"FjernvarmeBlokvarme", :means=>"NotDefined"}, :outer_wall=>{:material=>"Mursten"}}}

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bbr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TO DO
write spec
find more data to output
