class FetchFriendsJob < ApplicationJob
  queue_as :default

  def perform(watcher)
    puts watcher.id
    FriendsService.new(watcher).fetch
  rescue => e
    ActiveJob::Base.logger.error e
    raise e
  end
end
