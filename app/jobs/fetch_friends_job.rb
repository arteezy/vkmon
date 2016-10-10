class FetchFriendsJob < ApplicationJob
  queue_as :default

  def perform(watcher)
    WatchersFriendsService.new(watcher).fetch_friends
  end
end
