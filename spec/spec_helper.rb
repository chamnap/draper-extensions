require "simplecov"
require "coveralls"
require "codeclimate-test-reporter"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start do
  add_filter "/spec/"
end

require "pry"
require "active_record"
require "mongoid"
require "kaminari"
require "draper-extensions"

[:active_record, :mongoid].each do |orm|
  ActiveSupport.on_load orm do
    Draper.setup_orm self
  end
end
Kaminari::Hooks.init

# active_record
if Gem.loaded_specs["activerecord"]
  load File.dirname(__FILE__) + "/config/active_record/connection.rb"
end

# mongoid
if Gem.loaded_specs["mongoid"]
  load File.dirname(__FILE__) + "/config/mongoid/connection.rb"
end

MODELS = File.join(File.dirname(__FILE__), "app/models")
$LOAD_PATH.unshift(MODELS)

# Autoload every model for the test suite that sits in spec/app/models.
Dir[ File.join(MODELS, "*.rb") ].sort.each do |file|
  name = File.basename(file, ".rb")
  autoload name.camelize.to_sym, name
end

DECORATORS = File.join(File.dirname(__FILE__), "app/decorators")
$LOAD_PATH.unshift(DECORATORS)

# Autoload every decorator for the test suite that sits in spec/app/decorators.
Dir[ File.join(DECORATORS, "*.rb") ].sort.each do |file|
  name = File.basename(file, ".rb")
  autoload name.camelize.to_sym, name
end


RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end