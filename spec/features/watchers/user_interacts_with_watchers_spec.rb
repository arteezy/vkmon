require 'rails_helper'
require 'support/features/clearance_helpers'

RSpec.feature 'User interacts with watchers' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'opens his own watcher' do
    sign_in_with(user.email, user.password)

    watcher = FactoryGirl.create(:watcher, user: user)

    visit watcher_path(watcher)

    expect(page).to have_content 'Added Friends'
  end

  scenario 'tries to open someone\'s other watcher' do
    sign_in_with(user.email, user.password)

    other_user = FactoryGirl.create(:user)
    other_watcher = FactoryGirl.create(:watcher, user: other_user)

    visit watcher_path(other_watcher)

    expect(page).to have_content 'You can access only your own watchers!'
  end
end
