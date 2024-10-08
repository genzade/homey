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
end
