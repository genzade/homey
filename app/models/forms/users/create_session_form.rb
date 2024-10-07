module Forms
  module Users
    class CreateSessionForm < Forms::ApplicationForm
      attr_accessor :email, :password
      validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
      validates :password, presence: true

      def save
        return false unless valid?
        unless user&.authenticate(password)
          errors.add(:base, "User not found")
          return false
        end

        true
      end

      def user
        @user ||= User.find_by(email: email)
      end
    end
  end
end
