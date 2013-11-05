[![Build Status](https://api.travis-ci.org/skyscrpr/imprenta.png?branch=master)](http://travis-ci.org/skyscrpr/imprenta)
[![Code Climate](https://codeclimate.com/repos/5272d3faf3ea004b9c013f64/badges/53c51fa28cabe58bf214/gpa.png)](https://codeclimate.com/repos/5272d3faf3ea004b9c013f64/feed)

# Imprenta - Publish and Serve Static Pages within Rails.

The goal of this gem is to provide an easy and efficient way to generate and serve
static pages within Rails. The perfect use case for this gem is when your users
generate some content that gets published and after this it almost never change. e.g: a blog post,
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
The id that just past to the method, is the one that Imprenta rack will use to find the static page.

Then in your routes add the following:

```ruby
get 'mystatic-pages/:id', :to => Imprenta.server
```

Now if you go to your server to following url:
```code
http://localhost:3000/mystatic-pages/mytemplateid
```

You should be able to see the page you cached in the publish action. 
## Configuration

### Middlewares

Imprenta allows you to customize the Rack Server (Imprenta.server) with your own middlewares. By defaut, it
will have loaded a middleware to handle 500,400,401,404, etc.

```ruby
Imprenta.configure do |config|
  config.middlewares.use Bugsnag::Rack
end
```

### Storage

Imprenta provides two kinds of storage to save the static pages: File and S3. The default one is file.
If you want to use s3, you can configure the gem the following way:


```ruby
Imprenta.configure do |config|
  config.storage :s3
  config.aws_bucket = "bucket"
  config.aws_access_key_id = "xxxxid"
  config.aws_secret_access_key = "xxxkey"
end
```

When using s3, it is strongly advisable to use it in conjunction with a reverse proxy (Varnish, Squid). 
Otherwise, it will be hitting s3 for every request. In rails you could use rack-cache and memcached with
a configuration like this: 

In your Gemfile:

```ruby
gem 'rack-cache'
gem 'dalli'
```

Then, in your initializer: 

```ruby
Imprenta.configure do |config|

  client = Dalli::Client.new('localhost:11211',
                             :value_max_bytes => 10485760)

  config.middlewares.use Rack::Cache,
                         verbose: true,
                         metastore: client, 
                         entitystore: client,
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
