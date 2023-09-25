require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }

  describe "#valid_credentials" do
    it "adds an error if authentication fails" do
      user = User.new(email: "test@example.com", password: "correct_password")

      allow(user).to receive(:authenticate).with("correct_password").and_return(false)

      user.valid_credentials

      expect(user.errors[:base]).to include("Invalid email or password")
    end

    it "does not add an error if authentication succeeds" do
      user = User.new(email: "test@example.com", password: "correct_password")

      allow(user).to receive(:authenticate).with("correct_password").and_return(true)

      user.valid_credentials

      expect(user.errors[:base]).to be_empty
    end
  end
end
