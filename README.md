## Installation

The old way:

```ruby
bundle && rake db:setup
```

Or with `docker-compose`:

```
docker-compose run web rake db:create && docker-compose up
```
