# MethodAnnotation

MethodAnnotation You can define the annotation function method.
Note translation function can also be added simply tagged to only cross-processing from applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'method_annotation'
```

install it yourself as:

    $ gem install method_annotation

## Usage

First, let's create your MethodAnnotation class

    require 'method_annotation'

    class MyMethodAnnotation < MethodAnnotation::Base
    end

Next, let's add your class to the method

    class Foo
      # To include a MethodAnnotation::Enable to enable MethodAnnotation
      include MethodAnnotation::Enable

      # write annotaion_name or 
      # "#{your annotation class}.name.underscore"
      # ex) MyMethodAnnotation => my_method_annotation
      my_method_annotation
      def bar
      end
    end

You can define an annotation in this way


About MethodAnnotation
- .annotation_name .annotation_name=

  You can set forth a annotation name

      class MyMethodAnnotation < MethodAnnotation::Base
        self.annotation_name = 'my_method_annotation'
      end

      MyMethodAnnotation.annotation_name
      => "my_method_annotation"

- .describe .describe=

  You can set forth a description

      class MyMethodAnnotation < MethodAnnotation::Base
        self.describe = 'sample annotation'
      end

      MyMethodAnnotation.describe
      => "sample annotation"

- .list

  Your class that defines your class, you get a list of methods

      MyMethodAnnotation.list
      => [[Foo, :bar]]

- .before .after

  You can define the processing to be performed in method execution before/after the target

      class MyMethodAnnotation < MethodAnnotation::Base
        # args is the argument of the method of target
        # param class is MethodAnnotation::Parameter
        before do |param|
          puts 'before'
        end

        # args is the argument of the method of target
        after do |param|
          puts 'after'
        end
      end
    
      class Foo
        include MethodAnnotation::Enable

        my_method_annotation
        def bar
          puts 'bar'
        end
      end

      Foo.new.bar
      => before
      => bar
      => after

- .around

  It is possible to define a process that encompasses the method of the target

      class MyMethodAnnotation < MethodAnnotation::Base
        # original is proc methods of target
        around do |param| 
          puts 'before'
          return_value = param.original.call(param)
          puts 'after'

          return_value
        end
      end
    
      class Foo
        include MethodAnnotation::Enable

        my_method_annotation
        def bar
          puts 'bar'
        end
      end

      Foo.new.bar
      => before
      => bar
      => after

- MethodAnnotation::Cache

  It is cached after the second time the execution result of the method is returned from the cache.

      require 'method_annotation'

      class Foo
        include MethodAnnotation::Enable

        cache
        def bar
          puts 'exec'
          'return value'
        end
      end

      foo = Foo.new
      foo.bar
      => exec
      => "return value"

      # The second time is not puts 'exec'
      foo.bar
      => "return value"

- MethodAnnotation::WillImplemented

  It method is expected to be implemented.

      require 'method_annotation'

      class Foo
        include MethodAnnotation::Enable

        will_implemented
        def bar
        end
      end

      class Hoge

        def bar
          puts 'hoge'
        end
      end

      class Hogehoge
      end

      Foo.new.bar
      => NotImplementedError: Please implement Foo#bar

      Hoge.new.bar
      => "hoge"

      Hogehoge.new.bar
      => NotImplementedError: Please implement Hogehoge#bar

- MethodAnnotation::Trace

  It is will trace the method. This is still a prototype.

      require 'method_annotation'

      class Foo
        include MethodAnnotation::Enable

        trace
        def bar
          Hoge.new.hogehoge
        end
      end

      class Hoge
        def hogehoge
        end
      end

      Foo.new.bar
      => <===== Foo.bar trace =====>
      => (irb):15: in `hogehoge'
      => (irb):9: in `bar'
      => <=========================>

Example1

    class PutsArg < MethodAnnotation::Base
      self.annotation_name = 'puts_arg'
      self.describe = 'output the arguments of the method'

      before do |params| 
        puts '-------args-------'
        puts *params.args
        puts '------------------'
      end
    end
    
    class Foo
      include MethodAnnotation::Enable

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
      self.describe = 'measure the processing time of the method'

      around do |param| 
        start = Time.now
        return_value = param.original.call(param)
        puts "#{Time.now - start} sec"

        return_value
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
      self.describe = 'convert the arguments to string'

      around do |param| 
        remake_param = MethodAnnotation::Parameter.new(args: param.args.map(&:to_s))
        param.original.call(remake_param)
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
    => arg1.class: String
    => arg2.class: String
    => 3.000860474 sec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/method_annotation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
