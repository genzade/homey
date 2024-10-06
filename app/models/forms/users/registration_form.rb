module Forms
  module Users
    class RegistrationForm < Forms::ApplicationForm
      attr_accessor :email, :password, :password_confirmation

      validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
      validates :password, presence: true, confirmation: true
      validates :password_confirmation, presence: true

      def save
        return false unless valid?

        user.save!

        true
      end

      def user
        @user ||= User.new(
          email: email,
          password: password,
          password_confirmation: password_confirmation,
        )
      end
    end
  end
end
