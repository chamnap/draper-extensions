# Draper::Extensions [![Build Status](https://travis-ci.org/chamnap/draper-extensions.svg?branch=master)](https://travis-ci.org/chamnap/draper-extensions) [![Code Climate](https://codeclimate.com/github/chamnap/draper-extensions.png)](https://codeclimate.com/github/chamnap/draper-extensions) [![Coverage Status](https://coveralls.io/repos/chamnap/draper-extensions/badge.png?branch=master)](https://coveralls.io/r/chamnap/draper-extensions?branch=master) [![Dependency Status](https://gemnasium.com/chamnap/draper-extensions.svg)](https://gemnasium.com/chamnap/draper-extensions)

Extends Draper by adding pagination and scoping methods

## Installation

Add this line to your application's Gemfile:

    gem 'draper-extensions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install draper-extensions

## Usage

This extension extends these things on the `draper` gem:

+ Add `#decorate` to `ActiveRecord::Relation`.

```ruby
> listing = Listing.first
> listing.events.decorate
=> #<Draper::CollectionDecorator:0x000001059500f0
 @context={},
 @decorator_class=EventDecorator,
 @object=
  [#<Event id: 1, name: "BugSmash", ar_listing_id: 1, created_at: "2014-05-10 12:43:16", updated_at: "2014-05-10 12:43:16">]>
```

+ Add `#decorate` to `Kaminari::PaginatableArray`.

```ruby
class Listing
  include Mongoid::Document

  embeds_many   :product_categories

  def products
    @products ||= Kaminari.paginate_array(product_categories.map(&:products))
  end
end

> listing = Listing.first
> listing.products.page(1).decorate
=> #<Draper::CollectionDecorator:0x000001059500f0
 @context={},
 @decorator_class=ProductDecorator,
 @object=
  [#<Product id: 1, name: "Laptop", created_at: "2014-05-10 12:43:16", updated_at: "2014-05-10 12:43:16">]>
```

+ Add `#decorates_scope` to `Draper::CollectionDecorator`.

```ruby
# app/models/listing.rb
class Listing
  include Mongoid::Document

  field       :name,   type: String

  embeds_many :events
end

# app/models/event.rb
class Event
  include Mongoid::Document

  field       :name,      type: String
  field       :starts_at, type: Time

  scope       :upcomings, -> { where(:starts_at.gt => Time.now) }

  embedded_in :listing
end

# app/decorators/listing_decorator.rb
class ListingDecorator < Draper::Decorator
  decorates_association :events, with: EventsDecorator
end

# app/decorators/events_decorator.rb
class EventsDecorator < Draper::CollectionDecorator
  decorates_scope :upcomings
end

> listing = Listing.first
> listing.decorate.events.upcomings
=> #<EventsDecorator:0x000001016e1ed0
 @context={},
 @decorator_class=EventDecorator,
 @object=
  #<Mongoid::Criteria
  selector: {"starts_at"=>{"$gt"=>2014-05-10 13:03:29 UTC}}
  options:  {}
  class:    Event
  embedded: true>
>
```
## Authors

* [Chamnap Chhorn](https://github.com/chamnap)
