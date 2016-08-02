require 'rails_helper'

RSpec.feature 'User visits home page' do
  scenario 'opens root path' do
    visit '/'
    expect(current_path).to eq root_path
  end

  scenario 'sees greetings' do
    visit root_path
    expect(page).to have_content 'Welcome'
  end
end
