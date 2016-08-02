require 'rails_helper'

RSpec.feature 'User visits status page' do
  scenario 'sees sign in requirement' do
    visit status_path
    expect(page).to have_content 'sign in to continue'
    expect(current_path).not_to eq status_path
  end

  scenario 'sees Rails version' do
    sign_in
    visit status_path
    expect(page).to have_content 'Rails'
  end

  scenario 'sees Ruby version' do
    sign_in
    visit status_path
    expect(page).to have_content RUBY_VERSION
  end
end
