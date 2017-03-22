require "pry"
CURRENT_PATH = ENV["PWD"]
[
"#{CURRENT_PATH}/binary_tree/**/*.rb",
"#{CURRENT_PATH}/specs/support/**/*.rb"
].each do |path|
  Dir[path].each { |f| require f }
end

RSpec.configure do |config|
  config.color = true
end
