class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV.fetch('ADMIN_EMAIL'), password: ENV.fetch('ADMIN_PASSWORD'), except: :about if Rails.env.production?
  include Clearance::Controller
end
