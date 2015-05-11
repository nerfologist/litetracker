# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
# Add additional requires below this line. Rails is not loaded until this point!

# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # fast headless JavaScript driver. Comment to use Selenium instead
  Capybara.javascript_driver = :webkit

  # if you set it to true, js feature tests will fail for lack of a common
  # database session
  config.use_transactional_fixtures = false

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do |example|
    if example.metadata[:js]
      DatabaseCleaner.strategy = :deletion
    else
      DatabaseCleaner.strategy = :transaction
    end

    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  # block all external URLs (network probs might pollute test results)
  config.before(:each, js: true) do
    page.driver.block_unknown_urls
  end

  # Omit "FactoryGirl." in front of method calls
  config.include FactoryGirl::Syntax::Methods

  config.infer_spec_type_from_file_location!

  config.include EmulateLoginMacros
  config.include LoginMacros
  config.include JsonMacros
end

