class MongoEvent
  include Mongoid::Document

  field :name,      type: String
  field :starts_at, type: Time

  scope :upcomings, -> { where(:starts_at.gt => Time.now) }
end