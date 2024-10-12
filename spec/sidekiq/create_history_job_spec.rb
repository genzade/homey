require 'rails_helper'

RSpec.describe CreateHistoryJob, type: :job do
  it "enqueues itself on default queue" do
    expect { CreateHistoryJob.perform_async }
      .to enqueue_sidekiq_job(CreateHistoryJob)
      .on("default")
  end

  it "creates a history record for trackable", :sidekiq_inline do
    user = create(:user, id: 1)
    trackable = create(:project)
    action = 'foo'
    tracked_field = 'bar'
    tracked_value = 'baz'
    form_klass = Forms::CreateHistoryForm
    stubbed_form = instance_double(form_klass, save: true)

    allow(form_klass).to receive(:new)
      .with(
        user,
        trackable,
        action: action,
        tracked_field: tracked_field,
        tracked_value: tracked_value,
      )
      .and_return(stubbed_form)

    CreateHistoryJob.perform_async(
      user.id,
      trackable.id,
      "Project",
      tracked_field,
      tracked_value,
      action,
    )

    expect(stubbed_form).to have_received(:save)
  end
end
