require 'rails_helper'

RSpec.describe Friend, type: :model do
  it 'has a valid factory' do
    expect(build(:friend)).to be_valid
  end
end
