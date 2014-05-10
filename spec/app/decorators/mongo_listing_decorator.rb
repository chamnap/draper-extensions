class MongoListingDecorator < Draper::Decorator
  delegate_all

  decorates_association :events, with: MongoEventsDecorator
end