require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vkmon
  class Application < Rails::Application
    Clearance.configure do |config|
      config.rotate_csrf_on_sign_in = true
    end
  end
end
