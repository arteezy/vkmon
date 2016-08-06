require 'rails_helper'
require 'support/features/clearance_helpers'

RSpec.feature 'User interacts with watchers' do
  given(:user) { create(:user) }

  before(:each) do
    sign_in_with(user.email, user.password)
  end

  scenario 'creates new watcher' do
    visit watchers_path

    fill_in 'VK ID', with: rand(1000)
    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Photo', with: 'https://example.com/image.png'
    click_button 'Create'

    expect(page).to have_content 'Successfully created watcher'
    expect(page).to have_content 'John Doe'
  end

  scenario 'fails to create new watcher' do
    visit watchers_path

    fill_in 'Full Name', with: 'John Doe'
    fill_in 'Photo', with: 'https://example.com/image.png'
    click_button 'Create'

    expect(page).to have_content 'Unable to create watcher!'
    expect(page).not_to have_content 'John Doe'
  end

  scenario 'opens his own watcher' do
    watcher = create(:watcher, user: user)

    visit watcher_path(watcher)

    expect(page).to have_content 'Added Friends'
  end

  scenario 'tries to open someone\'s other watcher' do
    other_user = create(:user)
    other_watcher = create(:watcher, user: other_user)

    visit watcher_path(other_watcher)

    expect(page).to have_content 'You can access only your own watchers!'
  end

  scenario 'destroys watcher' do
    watcher = create(:watcher, user: user)

    visit watchers_path

    click_link 'Destroy'

    expect(page).to have_content 'Watcher was successfully destroyed'
    expect(page).not_to have_content watcher.name
  end
end
