require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    specify do
      is_expected.to define_enum_for(:status)
        .with_values(
          ignition: "ignition",
          in_progress: "in_progress",
          completed: "completed",
        )
        .with_default(:ignition)
        .backed_by_column_of_type(:string)
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:project_users).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:project_users) }
    it { is_expected.to have_many(:comments).inverse_of(:project).dependent(:destroy) }
  end
end
