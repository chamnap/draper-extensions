## This extension allow us to invoke `pagination methods`
## on collection decorator
##
## @products = ProductDecorator.decorate_collection(mongo_listing.products.page(1))
## @products.current_page => 1
## @products.per_page     => 20

class Draper::CollectionDecorator

  if defined?(Kaminari)
    delegate  :current_page, :total_pages, :limit_value,
              :next_page, :prev_page, :total_count,
              to: :object

    def per_page
      object.limit_value
    end
  end

  ## Allow your collection_decorator to invoke `scope` methods
  ##
  ## > listing_decorator.product_categories.with_products
  # => #<ProductCategoriesDecorator:0x0000010a4125c0
  # @context={},
  # @decorator_class=ProductCategoryDecorator,
  # @object=
  # #<Mongoid::Criteria
  # selector: {"products"=>{"$exists"=>true}}
  # options:  {}
  # class:    ProductCategory
  # embedded: true>
  # >
  def self.decorates_scope(name)
    define_method(name) do
      raise ArgumentError, "#{object.klass.name} doesn't define scope: #{name}" unless object.respond_to?(name)

      object.klass.decorator_class.decorate_collection(object.send(name))
    end
  end
end