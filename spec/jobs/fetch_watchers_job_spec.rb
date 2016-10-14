require 'rails_helper'

describe FetchWatchersJob, type: :job do
  let(:watcher) { create(:watcher) }

  it 'queues the job' do
    expect {
      FetchWatchersJob.perform_later(watcher)
    }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'matches with enqueued job' do
    expect {
      FetchWatchersJob.perform_later(watcher)
    }.to have_enqueued_job.with(watcher)
  end

  it 'executes perform' do
    expect(WatchersFriendsService).to receive_message_chain(:new, :fetch_watcher)
    perform_enqueued_jobs {
      FetchWatchersJob.perform_later(watcher)
    }
  end
end
