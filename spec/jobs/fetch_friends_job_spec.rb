require 'rails_helper'

RSpec.describe FetchFriendsJob, type: :job do
  it 'matches with enqueued job' do
    ActiveJob::Base.queue_adapter = :test
    watcher = FactoryGirl.create(:watcher)
    expect {
      FetchFriendsJob.perform_later(watcher)
    }.to have_enqueued_job.with(watcher)
  end
end
