require 'rails_helper'

RSpec.describe Forms::Users::CreateSessionForm, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to allow_value("foo@mail.com").for(:email) }
  it { is_expected.not_to allow_value("foo.mail.com").for(:email) }

  describe "#save" do
    context "when the form is valid" do
      context "when the user exists" do
        it "returns true" do
          create(:user, email: "john@doe.com", password: "asdfasdf")
          form = Forms::Users::CreateSessionForm.new(
            email: "john@doe.com",
            password: "asdfasdf",
          )

          expect do
            expect(form.save).to be(true)
            expect(form.errors).to be_empty
          end

          expect(form.save).to be(true)
        end
      end

      context "when the user does not exists" do
        it "returns true" do
          form = Forms::Users::CreateSessionForm.new(
            email: "john@doe.com",
            password: "asdfasdf",
          )

            expect(form.save).to be(false)
            expect(form.errors.full_messages).to include(
              "User not found",
            )
        end
      end
    end
  end
end
