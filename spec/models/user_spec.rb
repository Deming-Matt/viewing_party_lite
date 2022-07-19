require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_parties) }
  it { should have_many(:parties).through(:user_parties) }
  it { should have_secure_password }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  it {should validate_uniqueness_of(:email) }

  describe 'password test' do
    it 'should be able to confirm passwords' do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end

  describe "Logging In" do
    it "can log in with valid credentials" do
      user = User.create!(name: "funbucket13", email: "fb13@zmail.com", password: "test", password_confirmation: "test")

      visit "/login"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Log In"

      expect(current_path).to eq(root_path)

      expect(page).to have_content("Welcome, #{user.username}")
    end
  end
end
