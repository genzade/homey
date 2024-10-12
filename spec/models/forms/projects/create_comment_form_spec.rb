# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forms::Projects::CreateCommentForm, type: :model do
  describe "#save" do
    context "when form is invalid" do
      it "does not create a new comment", :aggregate_failures do
        form = Forms::Projects::CreateCommentForm.new(nil, nil, body: "")

        expect do
          expect(form).to validate_presence_of(:body)
          expect(form.save).to be(false)
          expect(form.errors.full_messages).to include(
            "Body can't be blank",
            "You must be logged in to leave a comment",
          )
        end.not_to change(Comment, :count)
      end
    end

    context "when form is valid" do
      it "creates a new comment", :aggregate_failures do
        user = create(:user)
        project = create(:project)
        form = Forms::Projects::CreateCommentForm.new(
          user,
          project,
          body: "comment body",
        )

        expect do
          expect(form.save).to be(true)
        end.to change(Comment, :all)
          .from([])
          .to(
              a_collection_containing_exactly(
                an_object_having_attributes(
                  body: "comment body",
                  user_id: user.id,
                  project_id: project.id,
                ),
              ),
            )
          .and enqueue_sidekiq_job(CreateHistoryJob)
          .with(
            user.id,
            a_value,
            "Comment",
            History::ACTION_OPTIONS[:created],
          )
      end
    end
  end
end
