require 'rails_helper'

RSpec.describe Forms::Users::RegistrationForm, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:password_confirmation) }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value("foo@mail.com").for(:email) }
  it { is_expected.not_to allow_value("foo.mail.com").for(:email) }

  describe "#save" do
    context "when the form is valid" do
      it "creates a user, returns true" do
        form = Forms::Users::RegistrationForm.new(
          email: "john@doe.com",
          password: "123456",
          password_confirmation: "123456",
        )

        expect do
          expect(form.save).to be(true)
          expect(form.errors).to be_empty
        end.to change(User, :count).from(0).to(1)
      end
    end

    context "when the form is invalid" do
      it "returns false" do
        form = Forms::Users::RegistrationForm.new(
          email: "",
          password: "",
          password_confirmation: "",
        )

        expect do
          expect(form.save).to be(false)
          expect(form.errors).not_to be_empty
        end.not_to change(User, :count)
      end

      context "when the email is invalid" do
        it "returns false" do
          form = Forms::Users::RegistrationForm.new(
            email: "john",
            password: "123456",
            password_confirmation: "123456",
          )

          expect do
            expect(form.save).to be(false)
            expect(form.errors.full_messages).to include(
              "Email is invalid",
            )
          end.not_to change(User, :count)
        end
      end
    end
  end
end
