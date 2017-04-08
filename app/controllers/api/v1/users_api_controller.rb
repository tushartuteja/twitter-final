module Api
  module V1
    class UsersApiController < ::ApiController

      def sign_in
        email = params["email"]
        password = params["password"]
        user = User.find_by_email(email)
        if user
          if user.valid_password? password
            data = Hash.new
            data["access_token"] = user.access_token
            return response_data(data, "Signed In", 200)

          else
            return response_data({}, "Password Invalid", 200)

          end

        else
          return response_data({}, "User doesn't exist", 200)


        end
        return response_data({}, "Signed In", 200)
      end


      def generate_otp
        email = params["email"]
        user = User.find_by_email(email)
        if user
         user.generate_otp
          return response_data({}, "Please Verify OTP", 200)
        end
        return response_data({}, "User doesn't exist", 200)


      end


      def verify_otp
        otp = params["otp"].to_i
        email = params["email"]
        user = User.find_by_email(email)
        if user
          if user.verify_otp otp
            data = Hash.new
            data["access_token"] = user.access_token
            return response_data(data, "Signed In", 200)
          else
            return response_data({}, "Please Verify OTP, Used the latest otp", 200)
          end
        else
          return response_data({}, "User doesn't exist", 200)
        end
      end

    end
  end
end
