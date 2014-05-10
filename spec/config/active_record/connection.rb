require "active_record"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "spec/test.sqlite3")
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :ar_listings, :force => true do |t|
    t.string :name
    t.timestamps
  end

  create_table :ar_events, :force => true do |t|
    t.string :name
    t.references :ar_listing
    t.timestamps
  end
end