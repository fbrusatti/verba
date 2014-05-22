module Features
  module LoginHelper
    module Session
      include Capybara::DSL
      include RSpec::Matchers

      def logged_in?
        page.should have_link('Logout')
      end

      def logged_out?
        page.should have_content('Login')
      end
    end
  end
end
