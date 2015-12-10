# MethodAnnotation

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/method_annotation`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'method_annotation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install method_annotation

## Usage

Example1

    require 'method_annotation'
    
    class PutsArg < MethodAnnotation::Base
      describe 'output the arguments of the method'

      before do |*args| 
        puts '-------args-------'
        puts args 
        puts '------------------'
      end
    end
    
    PutsArg.description
    => "output the arguments of the method"    

    class Foo
      include MethodAnnotation::Enable

      # write "#{your annotation class}.name.underscore"
      puts_arg
      def hoge(arg1, arg2)
        puts 'hoge'
      end

      puts_arg
      def hogehoge(a: nil, b: nil)
        puts 'hogehoge'
      end
    end   

    Foo.new.hoge('abc', 123)
    => -------args-------
    => abc
    => 123
    => ------------------
    => hoge
    
    Foo.new.hogehoge(a: 'xyz')
    => -------args-------
    => {:a=>"xyz"}
    => ------------------
    => hogehoge

Example2

    class TimeMeasurement < MethodAnnotation::Base
      describe 'measure the processing time of the method'

      around do |original, *args| 
        start = Time.now
        original.call(*args)
        puts "#{Time.now - start} sec"
      end
    end
    
    class Bar
      include MethodAnnotation::Enable
      
      time_measurement
      def hoge(sleep_sec)
        sleep sleep_sec
      end
    end
    
    Bar.new.hoge(5)
    => 5.001199044 sec

Example3

    class ArgsToString < MethodAnnotation::Base
      describe 'convert the arguments to string'

      around do |original, *args| 
        original.call(*args.map(&:to_s))
      end
    end
    
    class Baz
      include MethodAnnotation::Enable

      args_to_string
      time_measurement
      def hoge(arg1, arg2)
        puts "arg1.class: #{arg1.class}"
        puts "arg2.class: #{arg2.class}"
        sleep 3
      end
    end

    Baz.new.hoge(123, { a: 'A' })
    arg1.class: String
    arg2.class: String
    3.000860474 sec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/method_annotation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
