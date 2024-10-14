require 'rails_helper'

RSpec.describe History, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:trackable) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    specify do
      is_expected.to define_enum_for(:action)
        .with_values(History::ACTION_OPTIONS)
        .backed_by_column_of_type(:string)
    end
  end

  describe "#author" do
    it "returns the email of the user" do
      user = build(:user)
      history = build(:history, user: user)

      expect(history.author).to eq(user.email)
    end
  end
end
