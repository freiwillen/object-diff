# ObjectDelta
[![Maintainability](https://api.codeclimate.com/v1/badges/5b33c6ee7b253ef2e87e/maintainability)](https://codeclimate.com/github/freiwillen/object-diff/maintainability)

Once upon a time there on a misterious project there  was a need in comparing objects by a provided key. This is how the task was accomplisehd.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'object_delta'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install object_delta

## Usage
Imagine that we have 2 objects:
```ruby
a = OpenStruct.new(:a => 1, :b => 2, :c => 3)
b = OpenStruct.new(:a => 2, :b => 2, :c => 7)
```

and we want to find difference by attributes ```:a```, ```:b``` and ```:c```:
```ruby
comparator = Comparator.new(:a, :b, :c)
comparator.diff(a, b)) # => {:a => [1, 2],  :c => [3, 7]}
```

You can find more examples at ```spec/object_diff/comparator_spec.rb```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/object_delta.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
