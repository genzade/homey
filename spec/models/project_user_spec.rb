require 'rails_helper'

RSpec.describe ProjectUser, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end
end
