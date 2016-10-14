namespace :watchers do
  desc 'Refresh all watchers'
  task refresh: :environment do
    puts 'Queuing watchers refresh...'
    Watcher.find_each do |watcher|
      FetchWatchersJob.perform_later(watcher)
    end
    puts 'Done'
  end
end
