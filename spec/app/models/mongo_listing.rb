class MongoListing
  include Mongoid::Document

  field       :name,   type: String

  embeds_many :events, class_name: "MongoEvent"
end