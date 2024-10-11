require 'rails_helper'

RSpec.describe Forms::CreateHistoryForm, type: :model do
  describe "#save" do
    context "when form is invalid" do
      it "does not create a new history", :aggregate_failures do
        form = Forms::CreateHistoryForm.new(nil, nil, {})

        expect do
          expect(form).to validate_presence_of(:trackable)
          expect(form).to validate_presence_of(:user)
          expect(form).to validate_presence_of(:action)
          expect(form.save).to be(false)
          expect(form.errors.full_messages).to include(
            "User can't be blank",
            "Trackable can't be blank",
            "Action can't be blank",
          )
        end.not_to change(History, :count)
      end
    end

    context "when form is valid" do
      it "creates a new history", :aggregate_failures do
        user = build(:user)
        trackable = build(:project)
        form = Forms::CreateHistoryForm.new(
          user,
          trackable,
          action: History::ACTION_OPTIONS[:created],
        )

        expect do
          expect(form).not_to validate_presence_of(:tracked_field)
          expect(form).not_to validate_presence_of(:tracked_value)
          expect(form.save).to be(true)
        end.to change(History, :all)
          .from([])
          .to(
            a_collection_containing_exactly(
              an_object_having_attributes(
                trackable: trackable,
                user: user,
                action: History::ACTION_OPTIONS[:created],
                tracked_field: nil,
                tracked_value: nil,
              ),
            ),
          )
      end

      context "when action is :updated" do
        it "validate presence of tracked_field and tracked_value", :aggregate_failures do
          user = build(:user)
          trackable = build(:project)
          form = Forms::CreateHistoryForm.new(
            user,
            trackable,
            action: History::ACTION_OPTIONS[:updated],
            tracked_field: "status",
            tracked_value: "completed",
          )

          expect(form).to validate_presence_of(:tracked_field)
          expect(form).to validate_presence_of(:tracked_value)
        end

        it "creates a new history", :aggregate_failures do
          user = build(:user)
          trackable = build(:project)
          form = Forms::CreateHistoryForm.new(
            user,
            trackable,
            action: History::ACTION_OPTIONS[:updated],
            tracked_field: "status",
            tracked_value: "completed",
          )

          expect do
            expect(form.save).to be(true)
          end.to change(History, :all)
            .from([])
            .to(
              a_collection_containing_exactly(
                an_object_having_attributes(
                  trackable: trackable,
                  user: user,
                  action: History::ACTION_OPTIONS[:updated],
                  tracked_field: "status",
                  tracked_value: "completed",
                ),
              ),
            )
        end
      end
    end
  end
end
