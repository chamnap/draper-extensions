## This extension allow us to invoke `pagination methods`
## on kaminari/paginatable_array

if defined?(Kaminari)

  require "kaminari/models/array_extension"

  class Kaminari::PaginatableArray
    def decorate
      Draper::CollectionDecorator.new(self)
    end
  end

end