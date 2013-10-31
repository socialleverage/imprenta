# Imprenta

The goal of this gem is to provide an easy and efficient way to generate and serve
static pages within Rails. The perfect use case for this gem is when your users
generate some content that gets published and then it barely changes. e.g: a blog post,
landing page, about.me, etc.

The gem will provide with methods to save generated templates as static html pages.
It also comes with a Rack server that allows you to serve the generated pages from
an endpoint within your App.

## Installation

Add this line to your application's Gemfile:

    gem 'imprenta'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imprenta

## Usage

In the action that you want to cache, use something like the following:

```ruby
def publish
  imprenta_cache_template(template:  "path/to/template",
                          layout: 'application',
                          id: 'mytemplateid')

  redirect_to root_path, success: 'Yei page published!'
end
```
  


Then in your routes add the following:

```ruby
get 'mystatic-pages/:id', :to => Imprenta.server
```

## Configuration

Imprenta allows you to customize the Rack Server (Imprenta.server) with your own middlewares. By defaut, it
will have loaded a middleware to handle 500,400,401,404, etc.

```ruby
Imprenta.configure do |config|
  config.middlewares.use Bugsnag::Rack
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
