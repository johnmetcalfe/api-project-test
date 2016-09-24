RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

require 'rspec'
require 'httparty'
require 'selenium-webdriver'
require 'yaml'
require 'JSON'
require 'pry'
require 'csv'
require 'nokogiri'

def create_book(title, body)
  @title = title
  @body = body
  #click New Book in Nav
  @driver.find_element(css: "body > div > nav > a:nth-child(2)").click
  #Enter Data
  @driver.find_element(css: "body > div > form > input[type='text']:nth-child(1)").send_keys @title
  @driver.find_element(css: "body > div > form > textarea").send_keys @body
  #Submit Data
  @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(5)").click

end

def create_game(title, body)
  @title = title
  @body = body

  #click New Voucher in Nav
  @driver.find_element(css: "body > div > nav > a:nth-child(4)").click
  #Enter Data
  @driver.find_element(css: "body > div > form > input[type='text']:nth-child(1)").send_keys @title
  @driver.find_element(css: "body > div > form > textarea").send_keys @body
  #Submit Data
  @driver.find_element(css: "body > div > form > input[type='submit']:nth-child(5)").click
end
