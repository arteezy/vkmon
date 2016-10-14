namespace :friends do
  desc 'Refresh all friends'
  task refresh: :environment do
    puts 'Queuing friends refresh...'
    Watcher.find_each do |watcher|
      FetchFriendsJob.perform_later(watcher)
    end
    puts 'Done'
  end
end
