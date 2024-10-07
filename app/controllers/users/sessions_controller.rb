module Users
  class SessionsController < ApplicationController
    def new
      user_session_form = Forms::Users::CreateSessionForm.new({})

      render locals: { user_session_form: user_session_form }
    end

    def create
      user_session_form = Forms::Users::CreateSessionForm.new(user_session_params)
      if user_session_form.save
        login(user_session_form.user)
        redirect_to root_path, notice: "Successfully logged in."
      else
        flash[:alert] = "Login failed. Please check your email and password."
        render(
          :new, locals: { user_session_form: user_session_form }, status: :unprocessable_entity
        )
      end
    end

    def destroy
      logout
      redirect_to root_path, notice: "Successfully logged out."
    end

    private

    def user_session_params
      params.require(:forms_users_create_session_form).permit(:email, :password)
    end
  end
end
