module SystemHelpers
  def sign_in_with(email, password)
    visit(new_users_session_path)
    fill_in("forms_users_create_session_form_email", with: email)
    fill_in("forms_users_create_session_form_password", with: password)
    click_button("Sign in")
  end

  def sign_up_with(**args)
    password = args.fetch(:password)

    fill_in("forms_users_registration_form_email", with: args.fetch(:email))
    fill_in("forms_users_registration_form_password", with: password)

    password_confirmation = args.fetch(:same_password, true) ? password : "-#{password}-"
    fill_in("forms_users_registration_form_password_confirmation", with: password_confirmation)

    click_button("Sign up")
  end

  def expect_page_to_display_sign_in_error
    expect(page).to have_content(
      "Login failed. Please check your email and password.",
    )
  end
end

RSpec.configure do |config|
  config.include SystemHelpers, type: :system
end
