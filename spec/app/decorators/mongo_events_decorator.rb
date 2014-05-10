class MongoEventsDecorator < Draper::CollectionDecorator
  decorates_scope :upcomings
  decorates_scope :invalids
end