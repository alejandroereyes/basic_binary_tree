require "pry"
Dir["#{ENV['PWD']}/binary_tree/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
end
