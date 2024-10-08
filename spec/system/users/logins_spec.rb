require "rails_helper"

RSpec.describe "Users::Logins", type: :system do
  context "with valid email and password" do
    it "user can sign in" do
      create(:user, email: "user@example.com", password: "Password1!asdf")
      sign_in_with("user@example.com", "Password1!asdf")

      expect(page).to have_current_path(root_path)
    end
  end

  context "with invalid password" do
    it "user cannot sign in" do
      create(:user, email: "user@example.com", password: "Password1!asdf")
      sign_in_with("user@example.com", "wrong_password")

      expect_page_to_display_sign_in_error

      expect(page).to have_current_path(new_users_session_path)
    end
  end

  context "with invalid email" do
    it "user cannot sign in" do
      sign_in_with("unknown.email.example.com", "password")

      expect(page).to have_current_path(new_users_session_path)
    end
  end
end
