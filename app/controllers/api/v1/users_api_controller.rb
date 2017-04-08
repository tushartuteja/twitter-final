module Api
  module V1
    class UsersApiController < ::ApiController

      def sign_in
        email = params["email"]
        password = params["password"]
        return response_data({},"Signed In",200)
      end

    end
  end
end
