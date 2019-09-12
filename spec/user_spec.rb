require './lib/entities/user'
require './lib/repositories/user_repository'
require 'bcrypt'

describe UserRepository do
  def create_test_user
    UserRepository.create(username: 'user', password: 'password')
  end

  describe '.create' do
    it 'creates and returns a new user' do
      user = create_test_user
      expect(user).to be_a User
      expect(user.username).to eq 'user'
    end

    it 'hashes the password' do
      expect(BCrypt::Password).to receive(:create).with('password')
      create_test_user
    end
  end

  describe '.find' do
    it 'returns user by id' do
      user = create_test_user
      retrieved_user = UserRepository.find(user.id)
      expect(retrieved_user).to eq retrieved_user
    end

    it 'returns nil if no id given' do
      expect(UserRepository.find(nil)).to eq nil
    end
  end

  describe '.authenticate' do
    it 'returns the user if authentication is successful' do
      user = create_test_user
      authenticated_user = UserRepository.authenticate(username: 'user',
                                             password: 'password')
      expect(authenticated_user.username).to eq user.username
    end

    it 'returns nil if user not found' do
      create_test_user
      authenticated_user = UserRepository.authenticate(username: 'nil',
                                             password: 'password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil if password does not match' do
      create_test_user
      authenticated_user = UserRepository.authenticate(username: 'user',
                                             password: 'nil')
      expect(authenticated_user).to be_nil
    end
  end
end