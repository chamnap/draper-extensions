class ArListing < ActiveRecord::Base
  has_many :events, class_name: "ArEvent"
end