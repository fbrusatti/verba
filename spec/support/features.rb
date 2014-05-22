RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end

Capybara::Session.send(:include, Features::LoginHelper::Session)
