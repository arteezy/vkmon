class FetchWatchersJob < ApplicationJob
  queue_as :default

  def perform(watcher)
    WatchersFriendsService.new(watcher).fetch_watcher
  end
end
