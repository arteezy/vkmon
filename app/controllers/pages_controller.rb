class PagesController < ApplicationController
  before_action :require_login, only: :status

  def home
  end

  def status
    @status = {
      ruby:          RUBY_VERSION,
      rails:         Rails.version,
      time:          Time.now.to_s(:long),
      puma:          Gem.loaded_specs['puma'].version,
      postgresql:    User.connection.select_value('SHOW server_version'),
      user_count:    User.count,
      watcher_count: Watcher.count,
      friend_count:  Friend.count
    }
  end
end
