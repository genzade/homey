require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project).inverse_of(:comments) }
    specify do
      is_expected.to belong_to(:parent).class_name("Comment").inverse_of(:comments).optional(true)
    end
    specify do
      is_expected.to have_many(:comments)
        .with_foreign_key(:parent_id).inverse_of(:parent).dependent(:destroy)
    end
  end
end
