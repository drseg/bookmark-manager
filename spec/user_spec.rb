require './lib/user'
require 'bcrypt'

describe User do
  describe '.create' do
    it 'creates and returns a new user' do
      user = User.create(username: 'user', password: 'password')
      expect(user).to be_a User
      expect(user.username).to eq 'user'
    end

    it 'hashes the password' do
      expect(BCrypt::Password).to receive(:create).with('password')
      User.create(username: 'user', password: 'password')
    end
  end

  describe '.find' do
    it 'returns user by id' do
      user = User.create(username: 'user', password: 'password')
      retrieved_user = User.find(user.id)
      expect(retrieved_user).to eq retrieved_user
    end

    it 'returns nil if no id given' do
      expect(User.find(nil)).to eq nil
    end
  end
end