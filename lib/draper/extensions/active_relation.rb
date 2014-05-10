## This extension allow us to invoke `#decorate` on active_relation objects
##
## @products = listing.products.page(1).decorate
## @products => Draper::CollectionDecorator

if defined?(ActiveRecord) &&
  ActiveRecord::VERSION::STRING.start_with?("4.") ||
  ActiveRecord::VERSION::STRING.start_with?("3.2")

  class ActiveRecord::Relation
    def decorate
      klass.decorator_class.decorate_collection(self)
    end
  end
end