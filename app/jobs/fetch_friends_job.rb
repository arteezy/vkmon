class FetchFriendsJob < ApplicationJob
  queue_as :default

  def perform(watcher)
    FriendsService.new(watcher).fetch
  end
end
