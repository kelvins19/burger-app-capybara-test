require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require "capybara/apparition"
require 'capybara/rspec'
require "pry"
require 'rspec'
require "dotenv/load"
require 'httparty'
require 'webdrivers'
require 'webdrivers/chromedriver'
require 'webdrivers/geckodriver'
require 'webdrivers/edgedriver'
# require 'discord-notifier'
require 'discordrb'
require 'discordrb/webhooks'

# Capybara.run_server = true
Capybara.app_host = ENV["SERVER_URL"]
Capybara.default_driver = :selenium
Capybara.default_selector = :css

if ENV["JAVASCRIPT_DRIVER"] == "selenium_firefox"
  Capybara.javascript_driver = :selenium_firefox
  Capybara.register_driver :selenium_firefox do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end
elsif ENV["JAVASCRIPT_DRIVER"] == "selenium_safari"
  Capybara.javascript_driver = :selenium_safari
  Capybara.register_driver :selenium_safari do |app|
    Capybara::Selenium::Driver.new(app, :browser => :safari)
  end
elsif ENV["JAVASCRIPT_DRIVER"] == "selenium_edge"
  Capybara.javascript_driver = :selenium_edge
  Capybara.register_driver :selenium_edge do |app|
    Capybara::Selenium::Driver.new(app, :browser => :edge)
  end
else
  # default driver is apparition
  Capybara.javascript_driver = :apparition
  Capybara.register_driver :selenium do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    if ENV["HEADLESS"]
      options.add_argument('--headless')
    end
    options.add_argument('--disable-infobars')
    options.add_emulation(device_metrics: { width: 1280, height: 960, touch: false })
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
end

Before do
  if [:selenium_firefox, :selenium_safari, :selenium_edge].include? Capybara.current_driver
    Capybara.page.current_window.resize_to(1460, 980)
  end
end

Capybara.default_max_wait_time = ENV["MAX_WAIT_TIME"].to_i

Capybara.ignore_hidden_elements = false

# DOWNLOAD_PATH = Dir.pwd + "/downloads"
# Capybara.save_path = DOWNLOAD_PATH

World(Capybara::DSL)

def discord_notify(content, embed_title, embed_desc)
  $discord = Discordrb::Webhooks::Client.new(url: ENV["DISCORD_WEBHOOK_URL"])
  $discord.execute do |builder|
    builder.content = content
    builder.add_embed do |embed|
      embed.title = embed_title
      embed.description = embed_desc
      embed.timestamp = Time.now
    end
  end
end