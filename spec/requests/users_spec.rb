require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(email: 'test@gmail.com', password: 'password123')
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = User.new(email: nil, password: 'password123')
    expect(user).to_not be_valid
  end
end
