module Features
  module SessionHelpers
    def login_with(provider, user, mock_options = nil)
      if mock_options == :invalid_credentials
        OmniAuth.config.mock_auth[provider] = :invalid_credentials
      else
        OmniAuth.config.add_mock(provider, {
          :uid => '12345',
          :provider => provider,
          :nickname => 'nickname',
          :credentials => {
            :token => 'token',
            :secret => 'secret'
          },
          :info => {
            :name => 'User Name',
            :email => 'user@email.com'
          }
        })
      end

      visit "/users/auth/#{provider}"
    end

    def bypass_authentication(user=nil)
      current_user = user.blank? ? create(:user) : user

      ApplicationController.send(:alias_method, :old_current_user, :current_user)
      ApplicationController.send(:define_method, :current_user) do
        current_user
      end
      @current_user = current_user
    end
  end
end
