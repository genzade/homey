require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:project_users).dependent(:destroy) }
    it { is_expected.to have_many(:projects).through(:project_users) }
  end

  describe 'validations' do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to normalize(:email).from(" ME@XYZ.COM\n").to("me@xyz.com") }
  end
end
