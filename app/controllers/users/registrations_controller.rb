module Users
  class RegistrationsController < ApplicationController
    def new
      registration_form = Forms::Users::RegistrationForm.new({})

      render locals: { registration_form: registration_form }
    end

    def create
      registration_form = Forms::Users::RegistrationForm.new(registration_params)

      if registration_form.save
        login(registration_form.user)

        redirect_to root_path
      else
        render :new, locals: { registration_form: registration_form }, status: :unprocessable_entity
      end
    end

    private

    def registration_params
      params.require(:forms_users_registration_form)
        .permit(:email, :password, :password_confirmation)
    end
  end
end
