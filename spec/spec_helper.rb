RSpec.configure do |config|
end

module Sorcery
  module TestHelpers
    module Rails
      def login_user_post(user, password)
        page.driver.post(user_session_path, { email: user, password: password })
      end
    end
  end
end
