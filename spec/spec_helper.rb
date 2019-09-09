# frozen_string_literal: true

require_relative './setup_test_database'

ENV['RACK_ENV'] = 'test'
ENV['ENVIRONMENT'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'rack/test'
require 'rspec'
require 'capybara/rspec'

Capybara.app = BookmarkManager

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end
