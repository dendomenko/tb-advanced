require 'rails_helper'
require 'capybara/poltergeist'
require "puma"
require 'capybara/email/rspec'
require 'thinking_sphinx'

RSpec.configure do |config|
  Capybara.javascript_driver = :poltergeist
  options = {js_errors: false}
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, options)
  end

  Capybara.server = :puma

  config.include FeatureHelpers, type: :feature

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, sphinx: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
