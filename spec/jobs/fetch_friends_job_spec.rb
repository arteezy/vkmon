require 'rails_helper'

RSpec.describe FetchFriendsJob, type: :job do
  let(:watcher) { create(:watcher) }

  it 'queues the job' do
    expect {
      FetchFriendsJob.perform_later(watcher)
    }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'matches with enqueued job' do
    expect {
      FetchFriendsJob.perform_later(watcher)
    }.to have_enqueued_job.with(watcher)
  end

  it 'executes perform' do
    expect(FriendsService).to receive_message_chain(:new, :fetch)
    perform_enqueued_jobs {
      FetchFriendsJob.perform_later(watcher)
    }
  end
end
